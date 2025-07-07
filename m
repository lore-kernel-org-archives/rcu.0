Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8696B1E4AB;
	Mon,  7 Jul 2025 13:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751894152; cv=none; b=NOhQaVhv3AFUOJxkJidg2W5ZRlrMZtfeSYJxjatVXy3pC28ZUe0TTi9IufPhBf2qfGyXg6/hvR+aGU4zvYN0+sL6OhNcBdvW7VDDxFdL1MCScnxx5G4hvq5DjcJMjhLoxEAq9WTsQD3onS81Fg0fzxvWije3yb7sCRVFTcHXwog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751894152; c=relaxed/simple;
	bh=WvK92SPSmMS3dpRDjSrlhNAeyZd3LjdOu4GPitB+uCo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwIu7QNimcLM3IaK4LLZVqo9f0XoTsQfCY+RGRHbrEblyWxNpVQHeGaOno/ncRmm3kIFdxNRJuYAdit3USfbYujSJ++ViLOOmZx/BLMRcxXgWXtJy6DV8OJ20EFY1G/8RGhL8N+uhaKb/J2kpUC07VAxAdCIeZbswjIpqv3nrCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDSIkeyD; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDSIkeyD"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-553dceb345eso3653651e87.1;
        Mon, 07 Jul 2025 06:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751894149; x=1752498949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VYx0mbXhO6tHN9Rl9G+7SmQU6ij6CMN6DXEWsUBLSiY=;
        b=CDSIkeyD5L5L1MEIpJ0gxkYGbOiiuPid6VJz3gzelYsHP70+qX0+p2ZcBCZfU6L16j
         vwlHiA6RV0WQ5Fh9Ap2ShaBq0OB5CNNlvJLnrf5qRO4r8/SfT07HDXROl3COghUz/UD1
         i8LIPn/BRj//Ic0Xy+mED8Hgv7K6ZQgPp6zYyztLjNRba7XISFr1gjup/nLgT2qKKk1J
         AgpN2efuL+Od4gVvYl3bemBJY9yY7Jy0yxsQ+WQtWFNIUZuHsgYUBCUh67T0h8URXfxi
         9WYuy+0dpbqI86sro8wIId95ZhNFcEGzdkQYLSNxpI8ltR9kWYKaf2OtmNudA2qmZpbK
         gtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751894149; x=1752498949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYx0mbXhO6tHN9Rl9G+7SmQU6ij6CMN6DXEWsUBLSiY=;
        b=YbQSdOUXvmGJwOtv984FhLYSvpHVOlaXeDmbOHBCtnVvXbuRpMhw3O1nO8bBrdzS9w
         K3cpnqra4FVK1eRNd/ZD8IwGotI/+zx9+nTM87TFBOwjy+Z/8ckJClHgjVxvBzdEAD0m
         Ht7KqjWXi30qiOhvVb+3Ll/Io3EYg1qS4NJ1y/13JiJtx0oDsf728eKrWro4F8dv5wfj
         F3WZm9RxoKXQOVbIThmGy8Yx9BAAB/UfM2rU39mLgloG9ivZFWLl5fig55MlhEnjjZnn
         816h6TV40fc3yFMspqYsuFNgWkO8L/ak9OrDBRSaH5wfap8/PiRm/W2koUBp1d80/BWc
         G3ZA==
X-Forwarded-Encrypted: i=1; AJvYcCVPfvw12LimT9+4riyYksGcoM/rVDTLkPgrIjsNUQlq56OlnVnC423zz9SRk5ZetETMgpVaGLczIiV+HC4=@vger.kernel.org, AJvYcCWl9vR/HgLO/kW8XL8I+r/O3aPyqxMEX5TbelFtjcgfmxea8z/fhGePPEh1XuC8rjGOboVd@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6OYJePB94kymet3mT6FcfjGEFZyllwgEBWlEiFcsTU+iQjNuy
	V7zTJrp83ENI/t96CtcsOi4kStAE8Gt1K5Inw4P9OqeUctqy9A102eG/
X-Gm-Gg: ASbGnctRgcgJpok2b3WLGTTM0WlAFsvc26KF4Gbq/t6gnhYZ4KnaSVSTtxe1rZxYkT1
	yiSX1V4iBroNI2ahO5vDJaunOVFC4Yjf77TMvdm9CR2I6FC1XKMuPcod039Ru+E4RufwmgmmORU
	A8lEJ1zDsbPJOAhRq06MHCW5fliDyK8PAUvwjQAqyDnplX7Lp/LlQVMWGWMbIz09f6K3JzceiBV
	IX3CWkyaxsWGJO4Rl4t/ijcIlmH8arCNkIZcg2rrpff/VQzLwj/ZM5VTnGLwnm+9AVGsxVP7BKF
	Z1fFN62FQN1BhvUwzqVCaD2u24O8fqOcqMkEG+Js5lMp4v5mm3m6bXKevEVm2hzUe21pr1S6p8g
	fmmbMHRo05yE=
X-Google-Smtp-Source: AGHT+IHwXTQuWK4ngCiVKCMKRs3GycnlMOonwcKkNKX31PcHxol+f6J6GXptPcpboKdRq3olFMzXbQ==
X-Received: by 2002:a05:6512:ac8:b0:554:f72c:819d with SMTP id 2adb3069b0e04-556de075fe4mr4199034e87.43.1751894148124;
        Mon, 07 Jul 2025 06:15:48 -0700 (PDT)
Received: from pc636 (host-95-203-1-180.mobileonline.telia.com. [95.203.1.180])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556383baedesm1337410e87.23.2025.07.07.06.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 06:15:47 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 7 Jul 2025 15:15:45 +0200
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: Re: [PATCH v3 2/2] Documentation/kernel-parameters: Update
 rcu_normal_wake_from_gp doc
Message-ID: <aGvIgTdZhUC6sKy7@pc636>
References: <20250702145938.66459-1-urezki@gmail.com>
 <20250702145938.66459-2-urezki@gmail.com>
 <aGajYsyMTAD17WIY@pc636>
 <fee9ae77-2d10-47d2-9fb6-ea6a1f850dd4@amd.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fee9ae77-2d10-47d2-9fb6-ea6a1f850dd4@amd.com>

On Mon, Jul 07, 2025 at 09:19:38AM +0530, Neeraj Upadhyay wrote:
> 
> 
> On 7/3/2025 9:06 PM, Uladzislau Rezki wrote:
> > On Wed, Jul 02, 2025 at 04:59:37PM +0200, Uladzislau Rezki (Sony) wrote:
> >> Update the documentation about rcu_normal_wake_from_gp parameter.
> >>
> >> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> >> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> >> ---
> >>  Documentation/admin-guide/kernel-parameters.txt | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> >> index f1f2c0874da9..f7e4bee2b823 100644
> >> --- a/Documentation/admin-guide/kernel-parameters.txt
> >> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >> @@ -5485,7 +5485,8 @@
> >>  			echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
> >>  			or pass a boot parameter "rcutree.rcu_normal_wake_from_gp=1"
> >>  
> >> -			Default is 0.
> >> +			Default is 1 if num_possible_cpus() <= 16 and it is not explicitly
> >> +			disabled by the boot parameter passing 0.
> >>  
> >>  	rcuscale.gp_async= [KNL]
> >>  			Measure performance of asynchronous
> >> -- 
> >> 2.39.5
> >>
> > Same this one. Are you planning?
> > 
> 
> Yes, will be including these in the PR for next merge window.
> 
Appreciate it and thank you!

--
Uladzislau Rezki
