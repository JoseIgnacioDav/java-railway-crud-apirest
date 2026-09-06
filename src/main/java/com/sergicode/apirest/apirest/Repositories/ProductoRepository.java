package com.sergicode.apirest.apirest.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import com.sergicode.apirest.apirest.Entities.Producto;

public interface ProductoRepository extends JpaRepository< Producto, Long> {

}
