Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B967178365
	for <rcu@vger.kernel.org>; Fri, 26 Jul 2024 09:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721986852; cv=none; b=m7Syt7HTbaLOGJRvQdLnTV9OoGgSsS4zKK9DZXY2xwcPbc1xZpYy07i6CuX6X19/stQkfA7lYKpanI0MU209uNgxFBjEM2v+Jfes9zlIW8qVc2lNCyUcOsKCoVa0njIitH2AmJ6QCuFj2U5bIgEKWN8kMgaCo0WSoSYtA7dBPVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721986852; c=relaxed/simple;
	bh=REuB5YOb/wxPQ5FOE3gwUmVnhCEuw5n23LIuVx9cWfg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atBBJaJsd49Qcx9rI5v9uHJpovz/Z6LsZe8L/OG/germ9wLGRH3ig4P91+bcS8GvgIF/OJykBbEU++vXBWrN59tgvT8KzxDn3ujY6IBgtEJ1yViiszUKY74+dC7rN18GBU6Dv1nJkBT6s2n2hH28Wixgw7VVVoQwInvjE4qSDGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfYlSFil; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfYlSFil"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52efba36802so1844866e87.2
        for <rcu@vger.kernel.org>; Fri, 26 Jul 2024 02:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721986849; x=1722591649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9XKH/1XXRddfq6FM5K3um05jFgZAL/dcezQzaeXuMZ8=;
        b=nfYlSFilmMAFc4mIH5UiTi5M10lQaXSB6IjYEfQtFwCaTmpKm2JtFWArN/69l742Nm
         +GWh64ArSFLqG5P5Kumtrjpnqz6t0MIdlTaG1SNnebOG/iLrEyGMYn085xwkMYQxHUBK
         WzNGcUd7eXsRWvLiBbqUIloFVKFWO0nmRmG0vgCrf8GR+o/58oGVGkQzefhPdemJ3pU3
         8prLo7RkSmS2iTMeOe+E9S7UQIDinM0B2q5wti2sjYuvYVW7GBYnCPLbDSoJr24AL9nJ
         ei66SP9/zQ/0F50KGV/LFxnmp5t6DOiONhZ3L6Dj4dTSbkk6FM8wdV9v20QjZECVZLRZ
         M3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721986849; x=1722591649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XKH/1XXRddfq6FM5K3um05jFgZAL/dcezQzaeXuMZ8=;
        b=cGmXorMvAvqRP0pM9rR647N62U23IspjQmFmZRpY6kmQki0q/G7so/V0qVPQoXdmWY
         KF7ChDNVO5fkVEVQz5nzt9Q/4jSjl9P5/VdVab2R70rwqhvv58Pqm/e7nqFs/3w4FEZU
         H7rwhT+wIPcr/dctesnnBNfIS+GtLq+abapVj8WgHs2fgbfEvQg6qZxaPP1mEOBEL1XI
         6+2OzYDWNzdld3sXAlVaEdZgZmHqh9G6fNeKndr4aqcgfe24VPB6xUnJk2OhzP+g8edD
         WWhSbfrRKddyIDTN+8afk6VJrJulwd+O8Cqi2GbIwnKIB69yDQuYh6v0LgQHZUCoWG4U
         QSAA==
X-Forwarded-Encrypted: i=1; AJvYcCUbGKRHUCde1N9S9geFMNmMXVDIc7is8L4/Y0SbDAGYeAEW7UNHK/Okb1EqUvfMG9nl5WI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwGFLBF4G+Hd9dqsEdLrHOPE2/6+PQayai26JxU2EOi3P4JCP5
	onOAgR4zkY2J8gbZEu3zcXqbT7mihwwiyNW7YgGeFVoz2OIThkKN
X-Google-Smtp-Source: AGHT+IGxteMPmO0hYq91n8+s1yudDcT2HcqxVBNrQbT21+vrNjk6GoCxOWwvDeq6puujqFjEZMxq6w==
X-Received: by 2002:a05:6512:124d:b0:52e:a60e:3a04 with SMTP id 2adb3069b0e04-52fd6098b28mr3833002e87.59.1721986849068;
        Fri, 26 Jul 2024 02:40:49 -0700 (PDT)
Received: from pc636 (host-90-235-0-241.mobileonline.telia.com. [90.235.0.241])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c2d48fsm444127e87.275.2024.07.26.02.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 02:40:48 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 26 Jul 2024 11:40:46 +0200
To: Vlastimil Babka <vbabka@suse.cz>,
	"Paul E. McKenney" <paulmck@kernel.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-mm@kvack.org, RCU <rcu@vger.kernel.org>
Subject: Re: [vbabka:slab-kfree_rcu-destroy-v1r0] [mm, slab] df00e211c9:
 WARNING:at_mm/slab_common.c:#kmem_cache_kfree_rcu_destroy_workfn
Message-ID: <ZqNvHo70xFX71LRu@pc636>
References: <202407251313.32e55498-oliver.sang@intel.com>
 <4b31f1be-fbc5-404b-8a4e-1eb2ad4111e3@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b31f1be-fbc5-404b-8a4e-1eb2ad4111e3@suse.cz>

On Fri, Jul 26, 2024 at 11:34:57AM +0200, Vlastimil Babka wrote:
> On 7/25/24 7:59 AM, kernel test robot wrote:
> > 
> > hi, Vlastimil Babka,
> > 
> > we noticed by this commit:
> > 
> > 7fd4dfd0d38db6f3 df00e211c9c11e8d20f2ea7b4ab
> > ---------------- ---------------------------
> >        fail:runs  %reproduction    fail:runs
> >            |             |             |
> >           6:6         -100%            :6     dmesg.WARNING:at_mm/slab_common.c:#kmem_cache_destroy
> >            :6          100%           6:6     dmesg.WARNING:at_mm/slab_common.c:#kmem_cache_kfree_rcu_destroy_workfn
> > 
> > below formal report just FYI what we observed in our tests. not sure if it's
> > valuable to supply any hints.
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "WARNING:at_mm/slab_common.c:#kmem_cache_kfree_rcu_destroy_workfn" on:
> > 
> > commit: df00e211c9c11e8d20f2ea7b4ab1d7c9760fe822 ("mm, slab: asynchronously destroy caches with outstanding objects")
> > https://git.kernel.org/cgit/linux/kernel/git/vbabka/linux.git slab-kfree_rcu-destroy-v1r0
> 
> Yes, that's expected proves we need the proper barrier added from the RCU
> folks :)
> 
Give me some time, i will implement it! After discussion with Paul it
should not be so hard :)

Thanks!

--
Uladzislau Rezki
