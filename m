Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C4C12C7F9;
	Wed,  7 Aug 2024 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723044957; cv=none; b=NLPIVf3OLIBISZpcYvFop85szviRRjpIdSx4iasad+M4tofrznlR5uX4KzOXzgolKv+fNCG+6zC6WgohbDCSs754BfKOwXFey8oQUMoDIN1We8UdGVfJ/5umkMKG/izGzKllqLPDsacdmn3JqbVcPqiimipIjlG2BNRGRM83FGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723044957; c=relaxed/simple;
	bh=k3PxtIupHrNQW/bsUgAZepWEXJnKAcFYhPNWDBP92IQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhPZjp6Smmf63vawJbz2E4mY5MokcLTgGcSkg5Xy82ByXc0Pvd6ldbZsEwkOiY8B5B8ClUfMkrMH/puCgAN8uqmgUg+v06ICYLaz+WCGyTeCVpDNWN0uV/WX5rDPaCUcLskoIUdrJpS2AU7QIwhNMLz+4EdZryPgO2L4dsegSA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ti4KAV3N; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ti4KAV3N"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ef7fef3ccfso20413061fa.3;
        Wed, 07 Aug 2024 08:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723044953; x=1723649753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cVEr0aO0K/x06b8dUZVTgdXp92deBtWSxvrc97+JRvw=;
        b=Ti4KAV3NKbL3sg9q7fUZBcBDlZM7MQ033H2SjvLq3s+FFeuOhmAuf/ug3nkgXR8DXE
         dI27JVc2vEK98s1xSwNY75XZBNZZwUfL2IZV0chWNBkG+6tQwMZFsXK3KMhimHNRS9eH
         xp/FMuej4BdaiC8lGj+elEk10bMZPrBvIBKK5cV5I4eYr0QD8VQyz7J/jyPGD5mtqkiO
         SawgG1qgvRqH0vLySSAXd/mHQJivUGQy6zq425f5V0stuecRpjupXywhRnR1ZGjExwVK
         L0GMJPoPTUTDud8uZGcaghpGpu6fwjxxV86ELphldAbd4biHU1R/kMrOhOpag2CdhRCL
         fjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723044953; x=1723649753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVEr0aO0K/x06b8dUZVTgdXp92deBtWSxvrc97+JRvw=;
        b=ZFHRvXWyR4yphOG0gENdIieavBKCWth7fcGc17yVmJ/QVwhb/8QSjDGHXTW4seN9yK
         JqfucXmr+CHJTdAeAmoWvMwQugDJA7r2J+kj77EDydavFS5O/PoaysEZZomI6PeIwY/e
         6jUIYRw0xi3EWZ0eUVEHRHVBCLjcwli+d/daEhHxbj/u1JXEt4fjKbA3YDWP+LoRHF/L
         zlyVoxSNMNhH1ru+h53lTF/lXIVqL/WugetkfChYhKDnqL8rZccmxF5tJGPELyRYg4h9
         feK5m+HJxvM9/gGNUcrdhzCjvcco0bqOKpJ3buZoKHWbelA5T3OmMbNbzoNoibw3uC24
         imTw==
X-Forwarded-Encrypted: i=1; AJvYcCXbLRpdIhAPuB43Ry+mrzZ3j2ueDTUZrXh1GuO8USEGVc6Q0E2E8NWdKgVsYqINQywDF8fB0x1Oyv8EhvZkf6fZDWEG/6mSpcjQpfTA9OrD/hW1hVFCRI3okUpxgdp3QU3tWHKfF8w4G7ZCl01f8DqW8Zsf7ZMeNMKsgHJpHjpoK4lw
X-Gm-Message-State: AOJu0YzkpoIbtXdr7PdtJ4JvnZGU9iFuCD/XhNuuoh+Z1L66bx1ng3JZ
	58bPC1jCVBIP0K0aHuOSmeXXAQ//uxASC26TLSzg9lNppTrSka7A
X-Google-Smtp-Source: AGHT+IF5cwkOGr4PC3JjvT3xqb3AwVylKmWlo8FQKOAQAJ0PDJEQOKNSQ6aV29gaPSxcFErnVVCjaw==
X-Received: by 2002:a05:6512:1310:b0:52c:d943:300f with SMTP id 2adb3069b0e04-530bb3bd90cmr13986276e87.38.1723044953047;
        Wed, 07 Aug 2024 08:35:53 -0700 (PDT)
Received: from pc636 (host-90-235-1-92.mobileonline.telia.com. [90.235.1.92])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530de3e2e7esm288517e87.51.2024.08.07.08.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 08:35:52 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 7 Aug 2024 17:35:49 +0200
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org, josh@joshtriplett.org, boqun.feng@gmail.com,
	urezki@gmail.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com, kees@kernel.org, gustavoars@kernel.org,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] rcu: Annotate struct kvfree_rcu_bulk_data with
 __counted_by()
Message-ID: <ZrOUVWMRQ5q-4Xpn@pc636>
References: <20240807095459.1400-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807095459.1400-2-thorsten.blum@toblux.com>

On Wed, Aug 07, 2024 at 11:55:00AM +0200, Thorsten Blum wrote:
> Add the __counted_by compiler attribute to the flexible array member
> records to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Increment nr_records before adding a new pointer to the records array.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  kernel/rcu/tree.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index e641cc681901..76d8d75dd8b3 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3227,7 +3227,7 @@ struct kvfree_rcu_bulk_data {
>  	struct list_head list;
>  	struct rcu_gp_oldstate gp_snap;
>  	unsigned long nr_records;
> -	void *records[];
> +	void *records[] __counted_by(nr_records);
>  };
>  
>  /*
> @@ -3767,7 +3767,8 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
>  	}
>  
>  	// Finally insert and update the GP for this page.
> -	bnode->records[bnode->nr_records++] = ptr;
> +	bnode->nr_records++;
> +	bnode->records[bnode->nr_records - 1] = ptr;
>  	get_state_synchronize_rcu_full(&bnode->gp_snap);
>  	atomic_inc(&(*krcp)->bulk_count[idx]);
>  
> -- 
> 2.45.2
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki
