Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795441240;
	b=uT8N44WdQzyXJqiA9qGsGbH2JIxADD2J/YazAfTs2EeKl7JCnOwVX1BuALKuNq/H5q1G
	 0NQ4VZskU9O77tPXAeFV0xUvrbd3S2MFIPNeXNPZxOV1avQ9QW4TnSQUCAG/9J7s5FDaC
	 A1ylv90oda+laton8vgTXkRA8xNAvFGUAnZ15IqguVPLn6d+Y7FvWMeLhQOxRPzYKR6LR
	 QvL8lxbYdr5ybDeWARUX9UX6Qi/TLs09EvqwlYZrzqwm/CmUFACYTYvVqoIov93avitVh
	 282lRFh08B1QlErY0FRkUn4kXhPno7sICknqpC9Kyh8RXMpEv7tPHqtb8ahXTi80rCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795441240;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=s8GkoF4Y0/ft7koVRoDNSDYckCyyov087UPkNw1u++8=;
	b=zMZAgaSK7gOTSKifuL/I2EOx1lSBDdthlwc1Y9Cu0AFX39fJVElFYwQ0Vcqpu2C8iCGk
	 1SrvUigKAhnR2T/AkkwkKM3brbrfhEnew40aAwCQkG7AyAmwkdiYY38e5lL/Moher4jqw
	 VfA0hCIHV2G6QBaN8QVEUYJQWWFiP9px/zdFBbJOTnOJhirPyI9I9lLF9O75Z7C+lcqMl
	 kfZQGJKis3VpnPFzcibgeO8suFL8FfJb5Zgv+In6bXqMtucEm+p8OFSYgkYectP0kQO5D
	 nQeNw5yujlim9igJGFzJTWmpj8wFARa+sEvcoNiY6SsI3f3r6oFycLS5OuJSheflgiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=YEPEIhrS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4E2606A31F
	for <rcu@vger.kernel.org>; Mon, 23 Nov 2026 13:40:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF4E2606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=YEPEIhrS
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c506a231b88so458960266b.3
        for <rcu@vger.kernel.org>; Mon, 23 Nov 2026 05:40:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795441238; cv=none;
        d=google.com; s=arc-20260327;
        b=SellYfVeWaexhi6xQDKf2E3rqnGzRYPcCF1y41TVa3qX1L1lwb9KYpoLYL4UF89QQ7
         9i78AFa8VEbmoCYE+CAM9uPeOkkrA2zYYdZ1J4XXv7hRgcCZnmb9al8sV9Y/IPGabShV
         a+YzUn924DEp7Al0ufgIt3kAqCqzgnoFlLVD02mjPcfQ5YpfrPP0dqeQo2O6Zzzffm6t
         2081cxzPnmFqZLP1GHcEiyCPXT9DcImReG8BfYp1LtxX5eI0dv2KD9iVMm2U4No9/gw8
         HICh+Nqh0hWebhhhtcxh6+3JE3QMzKyDpThqIOAOFLET9IotSIbLunJ5vl37eKwObAYz
         Srvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s8GkoF4Y0/ft7koVRoDNSDYckCyyov087UPkNw1u++8=;
        fh=G9D3iz5rsofVtdB7/g9jAsHGdlUW7I9MsgSxexgocz8=;
        b=DmgW8t/2hynhAebPFl0XlelVRZmU19+CzbCIuOgWPmBpZk0X2NNRg0KxpZHvTM806K
         KK/+8KNuvd9v/sgr5BTQMpl98IhO8cn92TMFGHQSWi7gbHp0qe12BsuvKEu/ObDy7/EE
         CskVFHXHcqDPTlBqg3VG0yc8wLflFA7m5IEroydvNQyX/1mPLw/YLDxqmpVuSN3MeNU6
         nqxnC/YsppCxXLhHAf5Vt+R2O7Ajv2e+93fngqUFkKwXzChsRHB3MCrpG3rWbMAkhRBu
         BLb9SHB794rxMz7ZFphaZut23BekEmcSgPV8MaYjQ4nME4tYbJrrPPV8G7eZOhky/hRU
         eOFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1795441238; x=1796046038; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s8GkoF4Y0/ft7koVRoDNSDYckCyyov087UPkNw1u++8=;
        b=YEPEIhrSw7Mo/1snAwEWtXXrwoWPKFfdzvZXjWa2s7ycoCqNoVkAFjWYVjj/1t57U/
         08j0B+j4a1dMnjaQJMUgWiqZc12Z9yJ1q9ZZBRdJzTRX9Rqg45mmNmI1kIcecfz9zEvG
         qB4aR4jxLinVh1d9X6NmfH0seZSowoCWzTcQPi4pd1SqnT4NS7295Ng4WrhJvUiXLBy0
         EeutDbcep87nGJ9UUKg1uTq5Z+a8LtEh45YPDnWVrqhmztqQGvvg5Sj5TvZ/GgQEbQ3O
         IrsliL+x51DnZO4fweV1Xz1h7Tc6Pal+z0982pYGWSCLdzGS51FBHv5YWQSaX5+WyBM/
         6abw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795441238; x=1796046038;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s8GkoF4Y0/ft7koVRoDNSDYckCyyov087UPkNw1u++8=;
        b=ffP5yG8GtAByDfvTwg2B/9saFSiucW3mT02qzfdD4XwPCreYJdlG6viTXNapKH0YB2
         5Wr3x3T/s3VQCBBOLwqEQTwRFon986OzWQvHzTa5v6B26N9/ezvDeztXuNjealnzWWCv
         Eoi6glVXeH0swj28Z75MIMAfFuVUlDS1ocyKn+ZTIltJDfYSbr2z6UGwuA5wKTymc2+l
         hcAx6mfk7PPNZDL17N/Ou6vczlbyePNTLjYRXgvj2j5XNOiCjbinSYflyg85ix3tWs0B
         1FB34sF7OvawI7cCuTYJLQ1RmXp0Heh5oKsVph8F8jmjly/nk7u3Yw7AbjSLc4fe8QZ0
         fL2Q==
X-Forwarded-Encrypted: i=1; AL+hErEZeYeVgOiSc6MPrMFUiWvQ3Q8AVkbU3+rK7K+Hh9V8nZineCOrAwFIz/9s5zeR9JZSXG8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9BBodoRq0gbxWM+NEuuyaHKT9UNgdioqQIw9bqQkbnAIxIE0wp
	BWSJTxH21AebZqjMlWq6eRAM8a5OVnwqLCKgI/TzGXu7Tq8ExDnzkPtSudRfOlMT/cVamD3Tffc
	9Zh7orVrWBAv66AXcGyYI3evbFkMk0P1G6PfdscvlVg==
X-Gm-Gg: AZFdTZep7mDUcPIdDk2Bt5fRKO9IMmQxG5ySW2/yQQKajihlids3YrqgFWkKtrJllTC
	h1rWl+pjIUTNXFGoWOorQJMB0i8WpG96DHjrxbCYAXtYM5JEtGPZxmcQXJbHuibUSXajISVjCag
	g1V8GEJJniJKKDhaA5aOoZoWtSxiteFxuPI9xC84gT1DRNAQ1iGFl28YfjPUZfCw6rbtQw6d1OW
	YEFTUxxeWrDzMQr8c6QkL3E4lqwSFv6Ibnz/FotfplGQweURdFtjV3fkWegLQkVQZEslq4VPez5
	H/M7GAWZKkJL7IB5ztXieG0/PLLqnwYBNB/9buheeiqIKAvCzRq9R2Bhwzx/b6aWcwiEtCgTahh
	WpLSW3G3ufQUtgnT/P7SElTTh3S4gV9NRLfuj84kMeruSkFicbwDy6HRf2Y8vhRVCRA==
X-Received: by 2002:a17:906:26cd:b0:c41:26b8:c49c with SMTP id
 a640c23a62f3a-c513a5db1d6mr705781866b.10.1795441238134; Mon, 23 Nov 2026
 05:40:38 -0800 (PST)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116081403.216452-1-max.kellermann@ionos.com>
 <20261116081403.216452-4-max.kellermann@ionos.com> <CAGsJ_4yZznwxOZmfeB2SpgT1enRbQMyKnN4QjEFdoN-PJi7mkg@mail.gmail.com>
In-Reply-To: <CAGsJ_4yZznwxOZmfeB2SpgT1enRbQMyKnN4QjEFdoN-PJi7mkg@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 23 Nov 2026 14:40:26 +0100
X-Gm-Features: Aa3M54rKU_f5FEXDCm7DW4j2_TEpJvEJvFs2TZ2jyZi7ub4II_dViU-T8MrTO6c
Message-ID: <CAKPOu+_SL_XBzgREAgptx8mVouOBg9xVj7q-DW0cyNHay8oHjg@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] mm/mglru: cache the last memcg node, make tail
 insertion constant time
To: Barry Song <baohua@kernel.org>
Cc: akpm@linux-foundation.org, kasong@tencent.com, qi.zheng@linux.dev, 
	shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, 
	david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 2:53=E2=80=AFAM Barry Song <baohua@kernel.org> wrot=
e:
> So this is the case where the list is empty, right? Maybe add a
> WARN_ON_ONCE() check before this code to make the assumption explicit
> and catch potential violations in the future.
>
> VM_WARN_ON_ONCE(!last !=3D hlist_nulls_empty(head));

Added, and I'll send v4 today.

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
