Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795439608;
	b=VXtwPHvp/vdtLGw07nEOabP3TeNzwoTZysnjN96ul/M+RVSWriOaNBKyg8mFmO1dCP8g
	 tMK2HyhM/T2OIKWkt8TJ3HHsolrbrVNLTVrNCUJpN9uwYbkhmgIdUddq+W0apn8hyDF85
	 XaaqCWm+9g9bIWZUrW+UccfiLolLPf/Uq/0wde4jiTjsRHybogopOyLHKf79fQPXFxuPW
	 P0jvjggC2Zlp8LcZKIKDiJQUiKroO6gazkEcbzF1Kf2Ub5601+3Qw/3fWw+LWHqirgRdw
	 bFhvgimjeiwKiOrh23Nqv+1KNcRu8Oew4slhTub4w/FQCl/r7llW5a672D0mcJP+p8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795439608;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=tQb6g9BiZ4ZosTHX5re+WDuvLyIDAspwcbz+If1/Czw=;
	b=KE0VVyfXqECYWZTI1oMSoTec+obMtLDpaquNA6YCcLmTffp9c3Otf4TiwTIQ1Xs/7VfD
	 g9HZALIh3IowCqFSzTfGl9FMdqdJQUXetMLL5p5jKgLlvJ8gUfwLymX8xsYD6EvA/CPUS
	 H33UzDHeTNt7wnyxO39gESUG4apX87vPSVH0AL0aD77EG00Y7Fztbv3MUM10mIF+o4jM4
	 Hkdtj0XvxNJsXix0lx+S8ubqr80gAVvEKbqCgZWGv+t60cKnaPpCKWxXYDN5eI/+fzmSc
	 8/er71d44u1RGWlDL8BXKnyE7cQ4tElY5LBgeREFg59go8zx5Ar3rKN5gxwx2WOQSIg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b="UjvV/f1P";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583D1606A31A
	for <rcu@vger.kernel.org>; Mon, 23 Nov 2026 13:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 583D1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=UjvV/f1P
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c4cb6834eaaso548604566b.2
        for <rcu@vger.kernel.org>; Mon, 23 Nov 2026 05:13:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795439606; cv=none;
        d=google.com; s=arc-20260327;
        b=GhmYuuTHvAgCt/smesuRrv3RViOupN9vS4bG6VZM6YXTdQ7Vje5Qld6iRSr9Xn3Yht
         hJNSGch9mSZP8I3oScryHx9APd0xfxfXKpAtTGDavGQGaUX8n084kBrT7A13NLLzwf8q
         7+ut7rFTP3Toqd761oF5WBZtOVdQ5G+nURZupFXOeiAQRu5cHLYup7mv7KhrThqHA4aJ
         mFzQQAHkC3X+YVQKkXIBVVXkxlkVLunW/3uWO1x8FgYhTLKvJEjzSAQ0ua2EGgKT2vIB
         YPTQVr7mUDi4SQ6rLo/Tu4pd83mCcAAn5UhmejK8LGVlrgIrSqOAbCx9GBRZMfUOhm5D
         6Dmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tQb6g9BiZ4ZosTHX5re+WDuvLyIDAspwcbz+If1/Czw=;
        fh=rShVJQe4ceDnx7oaMWhVIZ2kxU174zstcUDXqaVPnQ8=;
        b=KWxesjKFmB7CRZNDIlpRuBh62/Zby6F7D6KaHPorJKOBkWtXjP/DXvnlMa/LhZwEJM
         tyM1YmVDOPy9CvSfTuwzsYvIZhH03eO9VL2NCb6ayD4bEA0ILYYe+csDEsPh97N8IvvU
         RuvNczxFDfC+owq/R0Kg0o5utCKWg3n5UMrhnV6kWI0J+DEuwKOZC+CRT4A0h/r2qDJE
         t1m5FlrFyDwTGHySGIBuNlZnnEssMWS83tj4r62hetcunG59D5rvsqLqg4nEXORhPMgM
         0G9COJNatXB68V44KTgt6e0RZTrK3pu0rVUPCej5xoFuwPRs6PDa3HNtitr1OeRWzctu
         cVjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1795439606; x=1796044406; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tQb6g9BiZ4ZosTHX5re+WDuvLyIDAspwcbz+If1/Czw=;
        b=UjvV/f1PXeqJk3P43u6GpN2S80BHpyhQ/o3AlGZmFSM8kDX1olHEGYBAve6o9J5OHx
         Lv+vpFRMOJ0z6/iHEXqqjO8Jga0+77qSEsAtvXpgKp6rpu8wy9ZOUWKW1pu5Yn9MMB92
         sMrB1VXTjODKG4ZKK9I3Uy4+oyPG80+ZzzOqDyQBJhUOToARl9gZVY1e+gbBTZTdW9m1
         q7vxwP/mwAZ23/TV6zmTmmfouSoSNdgYHKnPlqQC5+YcQN6yFlpYmUJewiH5AQTbqgR1
         Io/7yRO9f3U8lTwd09oBO4eFWP+/00VtUXymu4CE4kRz2eaNapMATyEnnuPqLj5AY+r0
         ltlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795439606; x=1796044406;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tQb6g9BiZ4ZosTHX5re+WDuvLyIDAspwcbz+If1/Czw=;
        b=YBMviAWaqk9Fc5rxNsd3QRHA5K5aG4lTXKcZv3Fx5LuX3/5fWB1en+0w3GzBRUIO6N
         KOgHOya4/av8vpvY7Tni6vXsPijA3eWURxeQkVdb2FN5yoHzVZIq82c7zqnhDr8Z2etu
         Rhv2cYj5UAWUV52dwWk3x4U8dUS80tQygsKqQYD912EKVvoII0q2LsxlOwL50MZw4M4s
         PVClmNgl54JKempgYIkr5nk44WwEANXMT16dDz9O29Yon0zQOKNyw9jc1qo8jwocmUVV
         MRawhfURi7AEwDwwJibdFxak/vFCOPkErLrvp7H7BWIPzxw9OjxsHJSrnxxMJWG98SlZ
         9IPg==
X-Forwarded-Encrypted: i=1; AL+hErEoOz84mTlfcJhGSvDk+O+N0USGlulLJOr8yRSyyvSm7XpZg6T4uaiNzjv6D7ziNJ49+2w=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Ps4+OI4fwqgai2fJzQnlTsY7QnxQOyrjasHtKaruF5bKkJop2
	zRizZ9HaDYZ9yjwOYFqTvo96SFAdssZokh6q9Tnj8mlLNvfZZdd8EW2u1NzUXlwRa1rUNkU/eQi
	ugaqmIxoHW9K1iYAKwUkTaMK6fS2bOjXQd7Uj2xKBCg==
X-Gm-Gg: AZFdTZcGSrzL3GyHHrfqFxAvdQrgKSNtTiAaA1OpXEjU7dVwhjDUM9nBA4PkcUFZ9jS
	SuVkElmUg9nntnmd9FokqiKaOwBcgFEa38DYSOHCgtOUROu4veM1OC0+sObgmUgUXH5edjJ8SXR
	ck/m/sJ3Xw/PjYo6Q/RpnfOy4d4PQNvCRmlIrCKgRaxew4Lcu3+laRpHswoNELdZCPZY+PwLrR7
	9frZFa+7LXYVbwq62w9bbK8XUf0WHPMCPQ1O2AToxHJUFm+t9/k+uzVdPdHeBT2Hg3iXpitO/Z+
	/l2CQ31V6hIxPOKl0yt1VZH2Wc1P/f1d1R2vjmPn16dE+ufr3vYFUV4Us+C1sdNd4w6yMIlJQ8u
	7heokVtDHuXhLg3rW3Ixa+/NdbcQBkCJuZdPLNi+3BKoKm+l/JEvsx9NARornItnPuA==
X-Received: by 2002:a17:906:5453:b0:c50:5a51:632f with SMTP id
 a640c23a62f3a-c513aabad57mr752927566b.39.1795439605669; Mon, 23 Nov 2026
 05:13:25 -0800 (PST)
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
 <20261116081403.216452-5-max.kellermann@ionos.com> <CAGsJ_4w3cP+tgCGhTFu5p27Wi-9AFCneQgwLUAUg7X-gvX=e4Q@mail.gmail.com>
In-Reply-To: <CAGsJ_4w3cP+tgCGhTFu5p27Wi-9AFCneQgwLUAUg7X-gvX=e4Q@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 23 Nov 2026 14:13:11 +0100
X-Gm-Features: Aa3M54qkAN-FUxtSPdh9O8Qt6TQF6J4MfIqPGFS6SuLOsMmm0mfMW-dt_mgEmPk
Message-ID: <CAKPOu+-Pzp-ovWNq394yBD0Qa5zCLZjx=sE3ixLs+WLf4EgZBw@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] mm/mglru: avoid redundant rotations of young memcgs
To: Barry Song <baohua@kernel.org>
Cc: akpm@linux-foundation.org, kasong@tencent.com, qi.zheng@linux.dev, 
	shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, 
	david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 3:01=E2=80=AFAM Barry Song <baohua@kernel.org> wrot=
e:
> I know it was my suggestion to avoid unnecessary calls to
> get_random_u32_below() unless we actually need them.
>
> You then pointed out that this would move get_random_u32_below()
> inside the spinlock, which I had overlooked. Sorry about that.
>
> Have you tested whether calling get_random_u32_below() under the
> spinlock increases lock contention?

Yes, indeed it makes a big difference.

My initial version which always called get_random_u32_below() at the
beginning of lru_gen_rotate_memcg(), prior to locking
pgdat->memcg_lru.lock (but some of these "bin" values would never be
used with this patch):

                  &pgdat->memcg_lru.lock:     103487653      103501074
          0.06         301.90   195317628.84           1.89
113777275      116290184           0.04         339.54    30052760.20
         0.26

 Completed: 681 (success: 1, EAGAIN: 680, errors: 0)
 Elapsed: 61.23 s; requests/s: 11.12
 Latency: mean 713.05 ms; max 7470.24 ms

With the get_random_u32_below() call moved inside the lock, however
only called when it's really needed:

                  &pgdat->memcg_lru.lock:      99442644       99458122
          0.05         342.95   243043664.06           2.44
102985677      104642320           0.05         231.58    34095676.89
         0.33

 Completed: 548 (success: 0, EAGAIN: 548, errors: 0)
 Elapsed: 60.66 s; requests/s: 9.03
 Latency: mean 880.18 ms; max 3847.24 ms

I did a few runs, and while there was a lot of noise, but the
difference is real and reproducible.  Surprises me, I wouldn't have
thought this would be measurable.

I guess I'll move the call back out of the lock section?

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
