Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793770175;
	b=w3KWW+rTJAwg/LSiyaxJKuBzw3CZytAocMKN7uRmdooA76L2GRHWuAp1k3xSGQEkJiZP
	 JDOOWYoEePcUqxE5rxCWJj/0KKrLp+ioM8VN6LNQ0WmtQg7tQExgGoBOETucGzGrhN4tm
	 E/AHnREJk0GlPC6s2U1oJuCJCHpdJ4xo4TZpGD75mEiYnrJdITqLtjhv9i56ULW5QQoXE
	 wGXCv0FTfBQKB719wlEBJgM0XkNNGNrzUXnjN1UVswpVb5nL6Be7cCQoPiJAlSHqO05KN
	 bzwGzvE5PWWeD+lr8B8Dc2+vUh1jhcIsEw4Bp+5hU06ZFb+VEYzQdqQOgD+R1pKXT9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793770175;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cZhQHFa3fDIYYUFeduNwTqrhejieaNOw9vQ/LVe4bqc=;
	b=AEvi/FKvD7FGvTvaCm1T6wLZe9F89daShMfI57kaWQin6C46WINe/8c6vUif93xz0u9L
	 alvlITlw2/NL2CeaXBllO7evP1Fse/ly7gNuG2fO7/IDMk9CXA0wK0tNe+ohM62km4Fqg
	 xMnR14bf4ZR6Mu5XSsxa2UXl4VLZfA/6xRNhJaDzghmEzso0ZKvc9FsMicPXu7DAeflYJ
	 y9Iuy39MOu/rl3CezB4E7oGIILI8UpNyS/eyUA++4ke1Uq29MmgKGcG/GFffnBXlk8yON
	 PTagGGVJxs+1EJiS+xHDw8ZBZyPtgUBv0fYhj10XHVtq+B6eUGH4Ug0q0b7WEu4LpPg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=DM0AV0nR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473F3606A31B
	for <rcu@vger.kernel.org>; Wed,  4 Nov 2026 05:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 473F3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=DM0AV0nR
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c4395d31228so45352166b.1
        for <rcu@vger.kernel.org>; Tue, 03 Nov 2026 21:29:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793770173; cv=none;
        d=google.com; s=arc-20260327;
        b=dShzGt7t4lHhldbxISMXsdFEzMyzCKYbpx41blo5SGVqTH8FpKwKRp2SR2Q7B67KKB
         nt+KlDteDH7PFYTAPBFe2QCIbN1ud/2/nTm2J3V4ZMbr4830dZeG3eFvgNy/+ZvsRt5y
         54s/acuG9mE8BOHjsZQnSkp0jh8Rim3+jKQv8DMtlWYNfbozetHk8pymPyQfIt1kbBxq
         Xn1eFFEinNbf8BY9aSeJC2IP3xrVkWcCPBBPWTHgSo9KzrPivrvUJMXbI3ncPGFOayfl
         cI4fFI6Cjsn54ab7hJqkyj8bykFGRpukAXTbsriFQc6mEj8JCCec2E/AZ83kXd+BfxY4
         mHQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cZhQHFa3fDIYYUFeduNwTqrhejieaNOw9vQ/LVe4bqc=;
        fh=8kj5JoVgdgU2UjUcAWU/oPhE4vUy+4WWVCH0+tf9TpU=;
        b=H0+qUznu/4DatxIzmDXucreM57DTNZppZJz7ITlLyC3SERwUXpWbxpXZNtGfS21wgR
         rPp8hGUBOfdU+3tfHwjq6A1MpDcVhACrNMNJ3hwJtry67z1JE1iyWwaiBRt9W9yjB9Xe
         u8243LW/rGSMMGKvRgJyAa/+FOHZOP62Ko3bvfNLOHHPIPSaJEkHVBMLcEw2SNePEYOD
         kvtaBX/0Z4dbj+9K27pMV0xG8K6UFTNAr1bf67NlG5RFIjfxEwVEJNElvq2VdVjdTq0A
         Tb4xjMaIS1P19CAgU+Ku3zqU0UTZO3eURUfg6p/MOwMtMTMtXhQ7cEnXd2BE8mpujm8I
         MqsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1793770173; x=1794374973; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cZhQHFa3fDIYYUFeduNwTqrhejieaNOw9vQ/LVe4bqc=;
        b=DM0AV0nR1BQA1P628Ldhvee2oaahZdOYA41MY0kthaIFX8ItSKnuUbPYPordN7Rhhv
         7RavjYmkHbKJaolJWCWy7JCck5RN83uyUWRBVB+jtOYrAEWR48gWoe9nryCfs7ljeT9i
         U64lUH24PFncHMDevpMzEOBp+yFm7h/NWItiD/hZxHQXf3Y70OWU4d/w2RQnJKF5adYT
         c/iPdVD8t6Zhy5tC39vz6u6n/I1oRkqXC+C5ExcKoohZbonOUaFw024ucQYIgLT365Nz
         OYjBuBtU15rlAkJbNY+tlc3hylia9xY8rfYGTK7WEtclpdQN/gov7OwFIsqeXW8pHOrE
         3fKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793770173; x=1794374973;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cZhQHFa3fDIYYUFeduNwTqrhejieaNOw9vQ/LVe4bqc=;
        b=rzMJfBCJYbmEEr2HvmrTPHgt4hX52q7jpcpyI1YVfH9yv5svYIrHZIs0Zk+tMdZsP8
         rwIH1knC4i67Xd4zwp7qLRey/yCm31tfa+uYyYKwmlujGulY4B2ODWdz6HS3pUS0hFbu
         LLrsulq9MqKivvCUaJS6pjrs/srbkvbzM9itnY8Z/tKTp6iqeYNB6LdN4aBMxVCUM1tu
         p8qKypkq4I8qZM59t3OmZfrRioRxiXG5Lk7ZqP7N67hsv+/TPhx0xVQVb5SlMq28Wdof
         Hxt/tFW/KDjLl4pJsVQho4EmWgmvAKMY+mmdM8U93PL025/7CF7XC53Qe4BzbuGxPa3g
         Z3xg==
X-Forwarded-Encrypted: i=1; AKwUvBzjfnRcxuF7RVtRECq5EoUugiq9uEiVnj/HSJ1v5nBLybhhD00ugTczzcSwQ/G76dMRJ5Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z+7gclSwZFPxESh171t/2g5d9U1bZjDdJqM8wBk8zXJSpxYjgzi
	l0uKt0MRsX4z2vhfXLRxbA+XbrKgZxA6Y6NCD6WehbjFXqzXUDIaCD1U0mypfKLBFDa8Scw20Wj
	dLHGXcnORIBk50HjHjAHcFOMploFjCWFmwo+KQtfG8A==
X-Gm-Gg: AYBFou0Ux3+lpRmNqKSUVqis2hY+8cMhZsUD5cS+WujvbSMxaxn18HW1xdL+TB9gXoH
	dfOvQjOPGkCM3soq5jMcwgu9O+0LtVR0hXPlcikdNPQ+0pduvKCiNu/8pqo5O0iwFpNEVu8yUJw
	9wjHurForTVAL12VQnJI46qoFOKgA32qiAqaB+5+khUaQXf1VzZZ0dFmMH+C3+sNd9YdRg3OGye
	oEfigng54V7t4kQR0X0mMfjgSbxzQOK4BPASaJw1U17ZSejrDWCgNQRhMPeLpvlhwsPoxxic/RH
	vg/ObCwrZayjnVyRidTZLMpY3028/lj2/UZMH7hDu3pUIAnwv+JR7ms+D1QYCoDqObAyurW43Jg
	JwJbiMiDkFOGXsyfhxF/t3hPDp6tBUV/VF0SoYdMhs53pOAHp6CEyaUyFN+EjvUL97Q==
X-Received: by 2002:a17:906:dc95:b0:c46:2987:2169 with SMTP id
 a640c23a62f3a-c4ca7a4f156mr1344359266b.24.1793770172638; Tue, 03 Nov 2026
 21:29:32 -0800 (PST)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103113711.1832834-1-max.kellermann@ionos.com>
 <20261103113711.1832834-3-max.kellermann@ionos.com> <CAGsJ_4wYYiHvDj4Bqbp_hg1H9-WsZvEBJ9h5eNdX-Kuib_f3DQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4wYYiHvDj4Bqbp_hg1H9-WsZvEBJ9h5eNdX-Kuib_f3DQ@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 4 Nov 2026 06:29:21 +0100
X-Gm-Features: AclHuK-8AA5Oj5_0e3X9V5IdkisojDeCpVwYIMpIa2E1dyyt14UIk9YqekGGG90
Message-ID: <CAKPOu+-BArn2FDfOWthdJHHbkeEBVAZ9z29XRT88tiXYO9rmHw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] mm/vmscan: move code to lru_gen_{add,del}_memcg()
To: Barry Song <baohua@kernel.org>
Cc: akpm@linux-foundation.org, kasong@tencent.com, qi.zheng@linux.dev, 
	shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, 
	david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 4:22=E2=80=AFAM Barry Song <baohua@kernel.org> wrote=
:
> Also, MEMCG_LRU_OLD has been removed as I replied to you in v1[2]

Oh, I rebased on linus/master and not mm-text.  I saw MEMCG_LRU_HEAD
was removed there which caused a rebase conflict, and thought your
mention of removing MEMCG_LRU_OLD was a mixup on your side, but it was
really me.  I'll post v3 (as soon as I have figured out the rest of
your reviews).

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
