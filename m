Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795469027;
	b=HPc+87LtJqxy0nnNHQ8psgX94CIqOn/KEJEwnKMN7H3Bv6JEjZNHKzrAgbq4AJlLEZ51
	 XLE88smmvbdpTkNeBTsdyu/HnmldECdtY2zMtv/QzhlWiMX3UYlmsh6VIn8xJtB+iDeyl
	 V+KParPofupUW8PFU17w7ZYWLOT2LWnQR4ddhm3SkcnxIRykxIzgJWpsyEsFArFBf0srz
	 SgqJTAD+X3jLAZuY+4Nfvdxar+YueNaWyGuZZe5smc4xCPgt6twMq9FKgxba6by60eyn4
	 +hEHrNpwPgrjGETaxeaI3/4SNMIflzbZzZWq6fnFFX+/m6MN785M3jtboi1LrKsRm2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795469027;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=DVAt2we2ngEUNATOIEmS0h16G43bUM0UOuNkbG4NCZQ=;
	b=AstIWYXRyXAWswX+eq5GHBWS/ITL0cDOhvnc7R+VAmMyxhs7R+hICvDyo0srlePIDlcv
	 hg6uklQYlOP1Bo899GMTRyn79ZwxWoe9w0CheXcaJ+O8lV0EXZFVqjelhFLKQ/BqNpVq9
	 lCn1d91rFChKX/M5NArhCOIYW3HX8ZTkQJTLFW8/F+ULqbfCZ9sjLOzKlrrVrXV+apDuY
	 Bv6qH1M6gxcBLx6GB0FcCDu0wQjLTU6aVkpVSHa1bgAcqT0W4oB/W2AfUn0aqnh4xk1ef
	 HbmcmLARk+NgwJCbP43c4ImJvH4DfUkzFggl3Jn5XcyM9I4WO159vw7B4m7np2PAyuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="k0n/Oo0m";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13879606A31E
	for <rcu@vger.kernel.org>; Mon, 23 Nov 2026 21:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k0n/Oo0m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DBE01F000E6
	for <rcu@vger.kernel.org>; Mon, 23 Nov 2026 21:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795469026;
	bh=DVAt2we2ngEUNATOIEmS0h16G43bUM0UOuNkbG4NCZQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=k0n/Oo0m66vECJjujn/GknnMZ+yIIg+csYryLX+vjqodMeLUfYzEAAZVFOrB5LhCq
	 ksAyGgAq2ydka1hTH6kri5qjX3qU6Hzpv+u4hbjhUqURQfXlA+fqB54x8+uGiYRzfg
	 ANqQG7OxiNz13w9yTnpKcyTpQNxpLUJBpfAH2T2nGgFro8mq7n2EivgDG5Z+sitYd8
	 zTc/4Hsf7pQdbSkY5Zq6i5wL0oLlNpU58bn1DM72IrNSYBJcQVY+EU2/jXtwg3oe60
	 HJFrsVnltNeV/uzg5jxR01IowHNqZzFoDneQvAjUxnX9j09UXDTvRPOGilQacp7roc
	 LjAR8mT8N9n1Q==
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9495d543c42so396301985a.3
        for <rcu@vger.kernel.org>; Mon, 23 Nov 2026 13:23:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHUN75rPkbos89aqm1G7NaFQaNomXMFkXQxOxd0p6A2HCLOa5ZYKwgJ2y5QVtnbA7Yf3Jk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/MWKg+A/0egAlZJLycCLDLsda0JBdZV1nvU7hEBJv/nSD6UtfL
	EFf+bbzjOGNq/0MtlWKwyCb5xcoaUyropAkSrPQwCZ9FgKdoaisS8LXr7J+Uw2z5Df2dBEXiPpB
	9eHEjBNuI6E0F7TJVGsedv5osGqL/BLg=
X-Received: by 2002:a05:620a:1b9c:b0:93f:643f:4f4f with SMTP id
 af79cd13be357-949ba9ce6b9mr1992217985a.50.1795469025645; Mon, 23 Nov 2026
 13:23:45 -0800 (PST)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123135200.4086519-1-max.kellermann@ionos.com> <20261123135200.4086519-5-max.kellermann@ionos.com>
In-Reply-To: <20261123135200.4086519-5-max.kellermann@ionos.com>
From: Barry Song <baohua@kernel.org>
Date: Tue, 24 Nov 2026 05:23:34 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4z8RPpAmASUdS3hw3DWC+6VtYQ0yKVDamtYkM4dND5SPw@mail.gmail.com>
X-Gm-Features: Aa3M54qcTL8SSAjAQ_RVHmHSBfar4B1hbLxQu69vEWbG1NZwuWI1C1D-CZ5boWY
Message-ID: <CAGsJ_4z8RPpAmASUdS3hw3DWC+6VtYQ0yKVDamtYkM4dND5SPw@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] mm/mglru: avoid redundant rotations of young memcgs
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, kasong@tencent.com, qi.zheng@linux.dev, 
	shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, 
	david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 9:52=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> Concurrent reclaimers can request promotion after another reclaimer
> has already moved a memcg into the young generation.  Requeueing it
> into a random bin again adds list mutations without advancing the
> old-generation scan.
>
> Therefore, skip `MEMCG_LRU_YOUNG` when the memcg is already in the
> default segment of the current young generation.
>
> In my micro benchmark, this increases the request rate by 36% and
> reduces the average duration of each write request by 27%.
>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---

Reviewed-by: Barry Song <baohua@kernel.org>
