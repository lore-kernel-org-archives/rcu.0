Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF3C2820A0
	for <rcu@vger.kernel.org>; Mon, 12 Jan 2026 10:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768212500; cv=none; b=r/tvaadRNsLSFUXasvFcyEAJRWepIXPKD2sMZoRc8rcMvKmvHf8fojOlvjcEKEPcGqQuqWraUVV7yX/UhnmukkLA0wSnd3AjUSVewOBBe5a3Ah8eJxJAW4K9Z3N0KKVrHy0QzSA/fTBVhxNpV9XW0791FEG0gXpSAHdJbx2QsYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768212500; c=relaxed/simple;
	bh=Sm1GNYAROrFvFSIWvQ9YePtmdCPGgXgVzy9GeGUj6nc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTrJpoHb688HpHuMsYYFiauHMjv6/6+TLWaEUld26LJE89prCl2XP1BoKtJRqQUvHTDPpRKRJTdBqNiy1zJ93N/UE0dUzC2S0pHF08hOr7mdGr8JCayWwjwJBmZZEShtBJYbEjt9958sUOQ0pyomfvP1Y+RXyVpFBr40rw9sspA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oa81hAea; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oa81hAea"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38316d0c26eso30256321fa.2
        for <rcu@vger.kernel.org>; Mon, 12 Jan 2026 02:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768212497; x=1768817297; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UOQbT+FOEjEmBL4X4VygvOh2W2gKP4jti2g0zEPIvFw=;
        b=Oa81hAeaIACUXQwD2TczgsdMhpxTyPKWBjEIl9ILhvRfuHEtwE4HaDqTdVfmRQcKnW
         xyF5IBp5V99+9Og5DrqtuNCwov5LuhCC+po0hz9domIsxGqJoQtNL6hF3dtJrbikoVlV
         /z4dIVhGpl0AbdTLTeVKZ45hQ7su+vlJ96gagNwCVY2F/cILSqlB1qXrzXKknEqtPW1L
         QNHylCLMfgQpetbMWlhvZICEBbLwb7zGrOA2+QJzf16H1vTTl8UDbVBZuGwNKmkC67Kg
         VUN+38MgARaAh988SOY1HpRA1VOK/5qHHLxNbist/897UlV5lu1fOKICirC4RKd7qOH7
         2gOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768212497; x=1768817297;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UOQbT+FOEjEmBL4X4VygvOh2W2gKP4jti2g0zEPIvFw=;
        b=MXaCvfab6KU0tklRikEPU65W4WAq667D4lv3/Efj/GSf8vySpgZ6KzXi7dvG6ciBtG
         Hl94fO93dQmFCeBIySU+j6cCfMKKKhEvQOQesjTfPVYgsxwwPGmRlcAS5GrGDEGZKqLy
         o6m8aVa8ZaHjEHlG14Issr3noIfErZb9eKUTY9XtO3Wk0rFfOZJTOWhyzB/4lUwjPXQl
         mFmZaOlDN2J2w4lf21pKQK/NwFCizxST7YHSoW/9trvdUWpYs56bceo5UOKagSfsrpAg
         FlfS8BPzx+/5/X5rxVGJc4joMxeB6+ncrg+cAk5VtaHJJ6GzCzaGv5q/szpVycU7cyca
         +1KQ==
X-Gm-Message-State: AOJu0YwUmiid3Um1gq7bmFYRXb8sisIQnYEtK9aEVFgxQZ+yNH3Zkrh2
	Z0m/5n/48FqjYp5sxRUdblY1UYey35iTRwK7EJZ1waUDzVByM3CkIMCL8CQMBQ==
X-Gm-Gg: AY/fxX6mnlq4FuUdGB1viQkBWCsFwUs0kH/f+kHSQZ9A/fA0CgzIH77xnLwnas+TyX9
	OpJ+jbhsXoFwLMVPONSWsQLx776+az03fSNnD4tbCYBesKFNLI4siDUVMsg3/dh74vPTMZWyy/8
	MmRLYn71IxfrvFRpYyxrmtpyZUqvu2qJMCDZzX5H4xWb7s5xfsGKo8Ykdgl2jXYnHszPRXFHSvi
	mgHjAlS+exbDt7IlC5cgJ75llVlu8IhuJuQqkEvwHWY1C7Ya/H0qNrNfwnGpzmUIujA8gkBnis1
	tY4Wm4qltpjXOhuvf86icuh+CDCSdR64QDGj7SxiCg67R/jBhYS+t0mTiO0H79QN5+OGbkWxlvW
	1eIup2783GKPwOoSfksui+/DiHA5A8STttSbnF7ViTO/X1WuQomK7qQNjxm75uDcP59YYppTZ2A
	BVQlzEnRklHzQRsJm3kgU3UlhGD1QqHpbnNwdYqw==
X-Google-Smtp-Source: AGHT+IGg5syzMGqO6wLb38BT+WbP++xk9obZqAn6I7H+ZXA7Z+YvWfcpW8nKMBwOhXDCjUqWFanc6Q==
X-Received: by 2002:a2e:a7cf:0:b0:383:1dff:8a8a with SMTP id 38308e7fff4ca-3831dff8cf9mr29927701fa.5.1768212496335;
        Mon, 12 Jan 2026 02:08:16 -0800 (PST)
Received: from pc636 (host-95-203-18-139.mobileonline.telia.com. [95.203.18.139])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-382eb7a5c1dsm38563641fa.16.2026.01.12.02.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 02:08:15 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 12 Jan 2026 11:08:12 +0100
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, paulmck@kernel.org,
	frederic@kernel.org, neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com, josh@joshtriplett.org, boqun.feng@gmail.com,
	urezki@gmail.com, rostedt@goodmis.org, tglx@linutronix.de,
	peterz@infradead.org, sshegde@linux.ibm.com, srikar@linux.ibm.com
Subject: Re: [PATCH] cpuhp: Expedite synchronize_rcu during CPU hotplug
 operations
Message-ID: <aWTIDGQ1_NYeO4iU@pc636>
References: <20260112094332.66006-2-vishalc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260112094332.66006-2-vishalc@linux.ibm.com>

On Mon, Jan 12, 2026 at 03:13:33PM +0530, Vishal Chourasia wrote:
> Bulk CPU hotplug operations—such as switching SMT modes across all
> cores—require hotplugging multiple CPUs in rapid succession. On large
> systems, this process takes significant time, increasing as the number
> of CPUs grows, leading to substantial delays on high-core-count
> machines. Analysis [1] reveals that the majority of this time is spent
> waiting for synchronize_rcu().
> 
> Expedite synchronize_rcu() during the hotplug path to accelerate the
> operation. Since CPU hotplug is a user-initiated administrative task,
> it should complete as quickly as possible.
> 
> Performance data on a PPC64 system with 400 CPUs:
> 
> + ppc64_cpu --smt=1 (SMT8 to SMT1)
> Before: real 1m14.792s
> After:  real 0m03.205s  # ~23x improvement
> 
> + ppc64_cpu --smt=8 (SMT1 to SMT8)
> Before: real 2m27.695s
> After:  real 0m02.510s  # ~58x improvement
> 
> Above numbers were collected on Linux 6.19.0-rc4-00310-g755bc1335e3b
> 
> [1] https://lore.kernel.org/all/5f2ab8a44d685701fe36cdaa8042a1aef215d10d.camel@linux.vnet.ibm.com
> 
Also you can try: echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
to speedup regular synchronize_rcu() call. But i am not saying that it would beat
your "expedited switch" improvement.

--
Uladzislau Rezki
