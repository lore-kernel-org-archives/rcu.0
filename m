Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990B927560B;
	Wed, 26 Feb 2025 20:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740602938; cv=none; b=JQgmYOjr0mXsh+KkOn2TtNzE+MTwIFDMp0vdd9g77q/v797skHUUBkJFhdChHwZkqZJB47hMO7pGZJKF7C6aIhMEly4Qum98Pf4dLifYjDciYBs0AgMEolpi2CCAgSwQtrpigduoYSSxvhyigrkKfdTi2OZaqKWyUNaERZyphYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740602938; c=relaxed/simple;
	bh=gZjBcOl/386CqJSbAK0vfOXEhFi8iYGEu8dKGfYaEDE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UM2I4WRu3owWk0oqFGs93Dh1r9j5j8VtUHgJm+q/9JszjY1JB11S760J97mhuuc9Sm5ZrnD904ezCDgPcs3dFINrF0M3/5cKPz+vK5dgXSBF+Ej/ybp4ZB53qgZBfyp8verMtnD+ft27XpGvTScE5yAH3O1VUhcYXU6hiHc0qY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9XutZNi; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9XutZNi"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5454f00fc8dso184179e87.0;
        Wed, 26 Feb 2025 12:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740602935; x=1741207735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T5LN/OwxnNW6hXEfH/vlgCwxT5V7SAIvLyLle5g1daI=;
        b=Y9XutZNipPcaaAF6zn38qwJr/jgt3dd+6Y05bVDB04yJiRNfHNeS0WFBbxo+OlE64c
         rM78+jwL1PV5R6eRs2a+gzVyYlehJeT5ozaFwVZFReWWplsyHub9Qg3aqZb1TamD6ymo
         v4qu+x6B+bu6H4xYay7NOXCTvFAh/tyqnr97zT1gbt/efYuWZWdd+/JJF75q9HuxHfMu
         07EViw/VWeozXYRSXBXOsSUJ4cEDGsFr1JayP3o+6Knz06srlq7+7sKh0eqdJNkvqeyk
         sDk663eRm5fTNYyympZYATYL5uHTKjkqgkn0EWgw0lHGaUXGt0x4PQr5KPk+r81/LfIX
         Igjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740602935; x=1741207735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5LN/OwxnNW6hXEfH/vlgCwxT5V7SAIvLyLle5g1daI=;
        b=WwvSg3IzeSrSMA1xHo8qrY0HhMRbIkj5sR3TNbKQhdhox/LOnb4pgdha9292ShILS0
         i1OCfmICeteQkOnenpb54dbKZobogRXPoH+Sr6JkBu9kZwouEFeXzuKr9eus5On1R8aL
         9ogAFc8xZjP8PJL+LuUSin39gfASG6oU4lsfuG/VWimUq+0YAEwD3htnLWRALYVLB3ow
         /9HwlE8uSdzUlat7P3FPJG8l8mzpn0WCwAROhCdzUCz2yJHqxxlRwPHkSF9e/Igq03aW
         3U7gnRMVAbyyi2191mRUREP2i6qOhNJKeWBY+JKemP0HphDJbuZPfVBmruwim7HGXEXu
         EcqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUS67DCXuyfYIfyWzaj7T5Et9oOlIiM+cIxAGhg8t1jJvVoGQwQqfeAuHnldiJWa6SWBKea@vger.kernel.org, AJvYcCWBOLdPc4k/dhflaO03a9CzCl309pYILozbTZL0NMQLB3XT4/bBVBc7JZA8l2usqx5x/1HaBDIgmiD2RdU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxyiw2isHgIluoJ/1pS8sokw8zQWr+d2QpqmzNbo8olgdxcsXy
	iIqb+XRr+RcG5KZTcv1PlD33IywWTzli0Kkr78LUugMCtHSgYF7l
X-Gm-Gg: ASbGncuKlpe8aXa1BmqKBkZF79Mf/i7YrklGfxTyT2Nc46NSAsmEkOPD4kqH3SV/ffo
	6XcFm+8OavaABbeuSvPQ/pW7pkvFusxC12B28nmbRkRCiAzOBbpfGM4PxiP7YyqM0417It6d78n
	LCSGKaYIxerLi2b4vU8qXuOdYf44xWjsc6DJOXggIZ7YW8J1mRy1jUHesCe+Xtroakbfv3w58FH
	y3mJF46HztvedHFYuu6rkc5a41gOrWLWaEr0OBRDAZ7opBbptFGOUkGZAi3ucbUm2Sr
X-Google-Smtp-Source: AGHT+IH4nWCLKEp9bNdPJh7bKmngRMcPhiiv96pUqJ1z6vVUk/7nMiqfAkvDV3dF+eQn4i1eSlN2VQ==
X-Received: by 2002:a05:6512:b0f:b0:53e:3a7c:c0b5 with SMTP id 2adb3069b0e04-5493c570467mr3182150e87.10.1740602934302;
        Wed, 26 Feb 2025 12:48:54 -0800 (PST)
Received: from pc636 ([2001:9b1:d5a0:a500::800])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a81ae8193sm6113851fa.105.2025.02.26.12.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 12:48:53 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 26 Feb 2025 21:48:52 +0100
To: Boqun Feng <boqun.feng@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v3 3/3] rcu: Use _full() API to debug synchronize_rcu()
Message-ID: <Z79-NAOoK-Vimgbr@pc636>
References: <20250225110020.59221-1-urezki@gmail.com>
 <20250225110020.59221-3-urezki@gmail.com>
 <Z79kKiokpq9FpjYc@boqun-archlinux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z79kKiokpq9FpjYc@boqun-archlinux>

Hello, Boqun.

> Hi Ulad,
> 
> On Tue, Feb 25, 2025 at 12:00:20PM +0100, Uladzislau Rezki (Sony) wrote:
> > Switch for using of get_state_synchronize_rcu_full() and
> > poll_state_synchronize_rcu_full() pair for debug a normal
> > synchronize_rcu() call.
> > 
> > Just using "not" full APIs to identify if a grace period
> > is passed or not might lead to a false kernel splat.
> > 
> 
> Could you provide detailed explanation on this? I.e. why is _full() is
> needed? I find the current commit message is a bit vague.
>
<snip>
rcu: Use _full() API to debug synchronize_rcu()

Switch for using of get_state_synchronize_rcu_full() and
poll_state_synchronize_rcu_full() pair to debug a normal
synchronize_rcu() call.

Just using "not" full APIs to identify if a grace period is
passed or not might lead to a false-positive kernel splat.

It can happen, because get_state_synchronize_rcu() compresses
both normal and expedited states into one single unsigned long
value, so a poll_state_synchronize_rcu() can miss GP-completion
when synchronize_rcu()/synchronize_rcu_expedited() concurrently
run.

To address this, switch to poll_state_synchronize_rcu_full() and
get_state_synchronize_rcu_full() APIs, which use separate variables
for expedited and normal states.
<snip>

Does it look better?

--
Uladzislau Rezki

