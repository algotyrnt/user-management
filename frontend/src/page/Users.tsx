// REACT imports
import type React from "react";
import { useEffect, useState } from "react";
// TYPE imports
import type { User } from "../types/user";
// SERVICE imports
import { userApi } from "../service/api";
// MUI imports
import {
  Box,
  Button,
  IconButton,
  Modal,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  Tooltip,
  Typography,
  Grid,
} from "@mui/material";
import AddCircleOutlineIcon from "@mui/icons-material/AddCircleOutline";
import EditIcon from "@mui/icons-material/Edit";
import DeleteIcon from "@mui/icons-material/Delete";
// COMPONENT imports
import AddUser from "../Components/AddUser";

const Users: React.FC = () => {
  const [users, setUsers] = useState<User[]>([]);
  const [addForm, setAddForm] = useState(false);
  const [editUser, setEditUser] = useState<User | null>(null);

  useEffect(() => {
    (async () => {
      try {
        const response = await userApi.getUsers();
        setUsers(response.data);
      } catch (error) {
        console.error("Error Fetching Users", error);
      }
    })();
  }, []);

  const handleUserListChange = (user: User) => {

    if (editUser) {
        const updatedUsers = users.filter((u) => u.id !== editUser.id); // Remove old user
        setUsers([...updatedUsers, user]);      // Add updated user
    } else {
      setUsers((prev) => [...prev, user]);
    }
    setEditUser(null);
    setAddForm(false);

  };

  const [searchTerm, setSearchTerm] = useState("");

  const handleSearch = async () => {
    try {
      const response = await userApi.searchUserByName(searchTerm);
      setUsers(response.data);
    } catch (error) {
      console.error("Error Searching Users", error);
    }
  };

  const updateUserAdded = (user: User) => {
    setEditUser(user);
    setAddForm(true);
  };

  const deleteUser = async (id: number) => {
    try {
      await userApi.deleteUser(id);
      setUsers(users.filter((user) => user.id !== id));
    } catch (error) {
      console.log("Error Deleting User ", error);
    }
  };

  return (
    <Box sx={{ width: "95%", padding: "20px" }}>
      <Grid container className="heading" justifyContent="space-between">
        <Grid>
          <Typography variant="h5" fontWeight="bold">
            User Management
          </Typography>
        </Grid>
        <Grid
          sx={{
            display: "flex",
            gap: 2,
            paddingLeft: "60%",
          }}
        >
          <input
            type="text"
            placeholder="Search by name"
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            style={{
              padding: "8px",
              borderRadius: "4px",
              border: "1px solid #ccc",
              fontSize: "16px",
            }}
          />
          <Button
            variant="outlined"
            onClick={handleSearch}
            sx={{ height: "35px" }}
          >
            Search
          </Button>
        </Grid>
        <Grid>
          <Button
            variant="contained"
            startIcon={<AddCircleOutlineIcon />}
            className="panel-btn"
            sx={{
              color: "#2AED8",
              borderColor: "#2AED8",
              backgroundColor: "#2AED8 !important",
              "&:hover": {
                backgroundColor: "#28C77F!important",
              }
            }}
            onClick={() => {
              setAddForm(true);
              setEditUser(null);
            }}
          >
            Add New
          </Button>
          <Modal
            open={addForm}
            onClose={() => {
              setAddForm(false);
              setEditUser(null);
            }}
          >
            <Box
              sx={{
                position: "absolute",
                top: "50%",
                left: "50%",
                transform: "translate(-50%, -50%)",
                p: 3,
                borderRadius: 2,
              }}
            >
              <AddUser
                onUserListChanege={handleUserListChange}
                existingUser={editUser}
              />
            </Box>
          </Modal>
        </Grid>
      </Grid>

      <Box className="List" sx={{ padding: "20px", width: "100%" }}>
        <TableContainer sx={{ maxWidth: "100%" }}>
          <Table size="medium">
            <TableHead>
              <TableRow sx={{ backgroundColor: "#f5f5f5" }}>
                <TableCell
                  sx={{ fontWeight: "bold", fontSize: "14px", padding: "20px" }}
                >
                  First Name
                </TableCell>
                <TableCell
                  sx={{ fontWeight: "bold", fontSize: "14px", padding: "20px" }}
                >
                  Last Name
                </TableCell>
                <TableCell
                  sx={{ fontWeight: "bold", fontSize: "14px", padding: "20px" }}
                >
                  Mobile
                </TableCell>
                <TableCell
                  sx={{ fontWeight: "bold", fontSize: "14px", padding: "20px" }}
                >
                  Email
                </TableCell>
                <TableCell
                  sx={{ fontWeight: "bold", fontSize: "14px", padding: "20px" }}
                >
                  Action
                </TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {users.map((user: User) => (
                <TableRow sx={{ backgroundColor: "#FDFDFD" }} key={user.id}>
                  <TableCell>{user.firstName}</TableCell>
                  <TableCell>{user.lastName}</TableCell>
                  <TableCell>{user.mobileNumber}</TableCell>
                  <TableCell>{user.email}</TableCell>
                  <TableCell>
                    <Tooltip title="Edit">
                      <IconButton onClick={() => updateUserAdded(user)}>
                        <EditIcon color="primary" />
                      </IconButton>
                    </Tooltip>
                    <Tooltip title="Delete">
                      <IconButton onClick={() => deleteUser(user.id)}>
                        <DeleteIcon color="primary" />
                      </IconButton>
                    </Tooltip>
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </TableContainer>
      </Box>
    </Box>
  );
};

export default Users;
