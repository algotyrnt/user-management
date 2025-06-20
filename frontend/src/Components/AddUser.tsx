// REACT imports
import React, {useEffect, useState, type ChangeEvent} from "react";
// MUI imports
import {Button, TextField, Typography, Paper,} from "@mui/material";
// SERVICE imports
import {userApi} from "../service/api.ts"; 
// TYPE imports
import type { newUser, User } from "../types/user.tsx";

interface AddUserProps {
    existingUser?: User| null;
    onUserListChanege: (user: User) => void;
}

const AddUser: React.FC<AddUserProps> = ({ onUserListChanege, existingUser }) => {
    const [formData, setFormData] = useState<newUser>({
        firstName: existingUser?.firstName || "",
        lastName: existingUser?.lastName || "",
        mobileNumber: existingUser?.mobileNumber || "",
        email: existingUser?.email || ""
    });

    useEffect(() => {
        if (existingUser) {
            setFormData({
                firstName: existingUser.firstName || "",
                lastName: existingUser.lastName || "",
                mobileNumber: existingUser.mobileNumber || "",
                email: existingUser.email || ""
            });
        } else {
            setFormData({
                firstName: "",
                lastName: "",
                email: "",
                mobileNumber: ""
            });
        }
    }, [existingUser]);

    const [errors, setErrors] = useState({
        firstName: "",
        lastName: "",
        mobileNumber: "",
        email: ""
    });

    const handleTextChange = (e: ChangeEvent <HTMLInputElement>) => {
        const { name, value } = e.target;
        setFormData((prev) => ({ ...prev, [name]: value }));
    };

    // Subimt button functionality
    const handleSubmit = async (e: React.FormEvent) => {
        
        e.preventDefault();

        let formErrors = {...errors};
        let isValid = true;

        if (!formData.firstName) {
            formErrors.firstName = "First Name is required";
            isValid = false;
        }

        if (!formData.lastName) {
            formErrors.lastName = "Last Name is required";
            isValid = false;
        }

        if (!formData.email) {
            formErrors.email = "Email is required";
            isValid = false;
        }

        if (!formData.mobileNumber) {
            formErrors.mobileNumber = "Mobile Number is required";
            isValid = false;
        }

        setErrors(formErrors);

        if (isValid) {
            try {
                if (existingUser) {
                    const updatedUser: User = {
                        ...existingUser,
                        ...formData
                    };
                    try{
                        const response = await userApi.updateUser(updatedUser);
                        onUserListChanege(response.data); // send updated user back to parent

                        setFormData({
                            firstName: "",
                            lastName: "",
                            email: "",
                            mobileNumber: ""
                        });
                    }catch (error){
                        console.log("Error Updating User: ",error);
                        setFormData({
                            firstName: "",
                            lastName: "",
                            email: "",
                            mobileNumber: ""
                        });
                    }

                }else {
                    const response = await userApi.createUser(formData);
                    onUserListChanege(response.data);  // send new user to parent

                    setFormData({
                        firstName: "",
                        lastName: "",
                        email: "",
                        mobileNumber: ""
                    });
                }
            }catch (error){
                console.error("Error Adding/ Updating User: "+error)
            }
        }
    };


    return (
        <Paper elevation={3} sx={{ padding: 4, maxWidth: "400px", margin: "20px auto" }}>
            <Typography variant="h6" fontWeight="bold" sx={{ mb: 1 }}>
                {existingUser ? "Update User" : "Add New User"}
            </Typography>

            <form onSubmit={handleSubmit} style={{ display: 'flex', flexDirection: 'column', gap: '20px' }}>
                <TextField
                    size="medium"
                    fullWidth
                    label="First Name"
                    name="firstName"
                    value={formData.firstName}
                    onChange={handleTextChange}
                    required
                    error={!!errors.firstName}
                    helperText={errors.firstName}
                />
                <TextField
                    size="medium"
                    fullWidth
                    label="Last Name"
                    name="lastName"
                    value={formData.lastName}
                    onChange={handleTextChange}
                    required
                    error={!!errors.lastName}
                    helperText={errors.lastName}
                />
                <TextField
                    size="medium"
                    fullWidth
                    label="Email"
                    name="email"
                    type="email"
                    value={formData.email}
                    onChange={handleTextChange}
                    required
                    error={!!errors.email}
                    helperText={errors.email}
                />
                <TextField
                    size="medium"
                    fullWidth
                    label="Mobile Number"
                    name="mobileNumber"
                    type="tel"
                    value={formData.mobileNumber}
                    onChange={handleTextChange}
                    required
                    error={!!errors.mobileNumber}
                    helperText={errors.mobileNumber}
                />

                <Button type="submit" variant="contained" color="primary" fullWidth>
                    {existingUser ? "Update User" : "Add User"}
                </Button>
            </form>
        </Paper>
    );
};

export default AddUser;
