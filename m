Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548521922E0;
	Tue, 25 Feb 2025 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501056; cv=none; b=UjKMUHAU6BXPPz2gl1FXvctwUlVOKPvmidu06zx7sNwXNi8Pv1sfqsEKwoZTZbpBzsGtoKiAKJ2S5mxwnSW+3DXTQS5jHG3/08mnniAayQ3bjdnd4ULeQWkCgfTMy38+4kRUWKF4a/sm3jK0fQeF/rwigVKjTD8LbMkqeKJ/wNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501056; c=relaxed/simple;
	bh=03u5U+dFYymXKHnP8w6UU60zTFXBwexn1/UzrBhmF+0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFbH9vG+6CAXJLQTglBzyyCqlL14/t1upkCti7uNn79WqJVqtyRgeR6jo3dmf+QEb2ZVE+ZS+LD+8UhJj6t7KfhEbPIV2fzhaOEP4qxujO3tmCTbqwSJ8zUufobKmtUl4UEDaFTr9os3fOLWGtTKNSfH8NxKF+8z5esP0qN+HA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pf3cy/Q3; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pf3cy/Q3"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30761be8fa7so54178371fa.2;
        Tue, 25 Feb 2025 08:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740501052; x=1741105852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RWbkOhLNSSWR0zjP+d4L6JQ+WlN91cu9FvFnwf55be4=;
        b=Pf3cy/Q3xL3tQpavUEEg3odKMRwnGtoGhgtc2ZYy58GVuwHWm9D8TBjngNQiaP48LK
         iUH+GAo2pdecj65LaX3HyByKaR8cMKeHkzciduhRyOJ6WUXfYLkmvc2pDnj3DkQwAtKI
         RQhkAdRMV5l4rB81O1D24QOYIRCH8xfAFSnXad28grNDxHW7mYbGfIazBFqj5Yz4hQlJ
         UKp4/kKMVMr/GLhtTrmP06uQJrDZ3TOJZxoeki0RHbiPhjonmiBnX2RnMkJrIaocZekx
         zw0uzYF568V/yyxqcZcUgUuD607OnxkrpjhSJTRsQdbGNzGKxGneQAwQ9pUAecoy945Q
         fwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740501052; x=1741105852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RWbkOhLNSSWR0zjP+d4L6JQ+WlN91cu9FvFnwf55be4=;
        b=ukezqJB0ZKm2iYqCuMOdcplMpIUZxp7bG4XlIJgsD8WaqAdMNrH2L1JaAQqN3VjAHY
         DiItfYt8VovvA5x9+EAc5pt8MX2QtKwRFXCjc852Na24Jh/nqKVujRr744eC39rPO6l7
         4umMSA6wZ9bSr61BlQxoh/uSULoBpuQVmE38MFTCHkdikF1AIS899vbYamTZOy6XQlUJ
         ugS+reQylMTSQM+95QMKlklzoNaLpY0JxRS8otBJyccSkCc/jqy7qMY8gzJX5ef6koJx
         n9lo9l3vJ4SBLEbMOxGQN+IH+iOmDCpfUuUmbRmO8hkzJ+Fq+zlk/b0i3qJSJUQ0cexQ
         PR6A==
X-Forwarded-Encrypted: i=1; AJvYcCURAahfKMycPs8eLd/1zAoWv68mrLqEo/nkmLGbSKe1eEPLCiYQcDnDNTpk3X3Cnj9xJ4bt@vger.kernel.org, AJvYcCWTnmDrgnDR7wX/0mF1eQbcJoXkartaR1DtOUEBPtypYnIzOGD5bv4M8dXCi74Zl3n0aTBY8/BuhZDtsCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoMu8QBmWx967v47J6AjrPUfJTpgZhVkl5Hpg5AF7SlvmwMmCU
	baEZm0S6tB01UkZJ1egFADC55shcvNAR8T9UlGAHLaJuzMDmi1L32tgDnO8A
X-Gm-Gg: ASbGncsrvvwTfhiZxFCDVeUfGvo13gn7avkG8J+hrmlnVsRvVgOh6e+zQSIz3cpSXgT
	VfOa+tEy71QeJJAi185rq4p3IAt9+7SE6CsRbuU7EqKHyF+iLmZz3iZDSSM6tXPaU9sObB7dJ2k
	MOVCt320n+gJMMsDvtThU1PjN8IXyr27Q2ZDXloUkBV0l5E2foYiSFGLfW0gEq7QDD5eWh8qye3
	VNQp9abOnYM7MmH+nazFTqOsSzxYskQeFBFOJdZVN6hg/QLAD8V7Cib8a2uvIZMBXxXixg0lwIk
	xuKuc9Qpn6Ss8Zz2yJ+ao5KFpoEmjjI6M1M40harXuI5fjvE
X-Google-Smtp-Source: AGHT+IFSvak0NKu7ubUS82xh1t7lwoaXY0RGlQtDf1wFAuasG1IoAfhlTynuuNxC/unkLkZZCVajYA==
X-Received: by 2002:a05:6512:1598:b0:545:5d:a5cd with SMTP id 2adb3069b0e04-54838ee1eb3mr6655612e87.6.1740501051882;
        Tue, 25 Feb 2025 08:30:51 -0800 (PST)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54852229486sm187367e87.101.2025.02.25.08.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 08:30:51 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 25 Feb 2025 17:30:48 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v3 3/3] rcu: Use _full() API to debug synchronize_rcu()
Message-ID: <Z73wOEBv9z4EtT56@pc636>
References: <20250225110020.59221-1-urezki@gmail.com>
 <20250225110020.59221-3-urezki@gmail.com>
 <b643758e-5a6a-41e7-9688-4a685ec48533@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b643758e-5a6a-41e7-9688-4a685ec48533@paulmck-laptop>

On Tue, Feb 25, 2025 at 07:48:55AM -0800, Paul E. McKenney wrote:
> On Tue, Feb 25, 2025 at 12:00:20PM +0100, Uladzislau Rezki (Sony) wrote:
> > Switch for using of get_state_synchronize_rcu_full() and
> > poll_state_synchronize_rcu_full() pair for debug a normal
> > synchronize_rcu() call.
> > 
> > Just using "not" full APIs to identify if a grace period
> > is passed or not might lead to a false kernel splat.
> > 
> > Link: https://lore.kernel.org/lkml/Z5ikQeVmVdsWQrdD@pc636/T/
> > Fixes: 988f569ae041 ("rcu: Reduce synchronize_rcu() latency")
> > Reported-by: cheung wall <zzqq0103.hey@gmail.com>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> This one passes light testing, so:
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> 
Thank you!

--
Uladzislau Rezki
