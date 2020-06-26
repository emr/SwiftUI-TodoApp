<?php

namespace App\Document;

use ApiPlatform\Core\Annotation\ApiResource;
use Doctrine\ODM\MongoDB\Mapping\Annotations\Document;
use Doctrine\ODM\MongoDB\Mapping\Annotations\Field;
use Doctrine\ODM\MongoDB\Mapping\Annotations\Id;

/**
 * @ApiResource()
 * @Document(collection="todos")
 */
class Todo
{
    /**
     * @Field(type="string")
     */
    public string $title;

    /**
     * @Field(type="string")
     */
    public string $description;

    /**
     * @Field(type="string")
     */
    public string $status;

    /**
     * @Field(type="date")
     */
    public \DateTimeInterface $createdAt;

    /**
     * @Field(type="date")
     */
    public \DateTimeInterface $dueDate;

    /**
     * @Id(type="string")
     */
    private string $id;

    public function __construct()
    {
        $this->createdAt = new \DateTime();
    }

    public function getId(): string
    {
        return $this->id;
    }
}
