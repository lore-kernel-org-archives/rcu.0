Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7140914D2B9;
	Mon, 16 Sep 2024 13:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726494896; cv=none; b=WQvEt5RV5ztZMsr68+vllkazFoA1b7qWuXudO9ukhB8GnDIy9izZeUT7L+J9xlyy1EHgggtP/oa0NVuMyvl9+6TgxtP1OV2KM+7DEpXrhSDTh7olzb4i93E1LV3SGVeOyNcoEzMtBe27zVk71D35rBbFb/WeOY5msvZxuDdeZg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726494896; c=relaxed/simple;
	bh=ShMh19eXn66OfcNsR+Um9oEAVTm7WA6a0G4IW6j2g3c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipX2yHSVghP/tmFiEBe6kRh75IXHZmNudXTEkdl5rA5mAMMNHOAFYFjc9z94gMJDKh4rWjvf6uzPePJxWMsJfMRmJROQy4PzkI7qEXsUUiNVFSFOQ8pM8u+nEsDcqHE0RCySGpquqDJ/Hs99VnSP0mnwnMpAjWRmPJ7ChBf0rSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdB26Zai; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdB26Zai"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-536748c7e9aso5268458e87.0;
        Mon, 16 Sep 2024 06:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726494892; x=1727099692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hn06ZJYaDUFnJPnf4C6Ys+vZTzawbTYLPbDQNaOjMFM=;
        b=EdB26ZaiUU7uZ25D1AHV+VOTWrwxl7eGBmT0fEPDLFN0iOC3woNONanSFsHHYzPDpG
         zj9ujrIZ6xK/bD2U2J71dSzv6Z5sMMcvGHq7kWdUH0knBIhTaVHBs9Og+QkQe4XbCEIW
         9YWm/3n/v4BkAQzPGeuWDaxE9n53wqY9ozie6QqlehrGJG02zL8Tnpc+n24Eadf6sU9j
         VJUVH+vChpfEYrb5g3tthyeBlsl4SGyiypmxyR4c4227iX3vc2P6oNtXgPSLnIjuqPLA
         pSiWDerh63/0IsNlcyqy6B8uoYi79Rjdx7rL1wXqnz6Hlu4x6o2LtTKfGhAsrPPJkis4
         rEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726494892; x=1727099692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hn06ZJYaDUFnJPnf4C6Ys+vZTzawbTYLPbDQNaOjMFM=;
        b=t3aO//bqfPTZSl6PnAUEc/ZzyoYukdADwEWfPc6YwPcvw6B6xfVQ1ndKtghV0vIU2i
         v3weV36k7INGibc9XbexP1kW8Gweq6E7uI61CzwDQWNJn7riMzvgcvRJQ9dMZlmAtSkT
         leJlHGJsxpkijktK6ERdRBYXTzIeT0Vze45ukk/srhdCSYyAoNlpOfXv43jNHQCxmu5V
         jGHey5k4GzYFA848Nvf0t1HDuTnEDoGyQxZWHrQUi1fU0rnKk1rvdgUx47PD352OJVN/
         mQySE4iwMJBUbZzqpAsSSa7zsxxXHa5qSkJONb/vXd1BHSyfwJGOQQ4F+WFAu3N5khvg
         p4lg==
X-Forwarded-Encrypted: i=1; AJvYcCUgqpWgFcEnFQHUHC1JWzcdAGEVkVPa3XFihANTpqBCb1JIK2Qm6qv4EgAS9g/qqtWKxJw6GMFbRoirhaU=@vger.kernel.org, AJvYcCWitELBrgF6L6SvxGuNhKHAGGLnYNqCB64x0pbBt23NtMddALwUoqwIbWWOM15jDeTuQq3e@vger.kernel.org
X-Gm-Message-State: AOJu0YyOYRfmW5MzS6DzVLNyB3oOtuBwXJ/7TmPuJwBT/IsTGX15MWKI
	JNJ9Hj9bpK9rDXoDqxeDz5sEZWZUhPrWziwmH9QiAKtqgRFyynpl
X-Google-Smtp-Source: AGHT+IEN253EXuKFClro3EtlnTNScTiUUEMnDfcaa1PG7dnUutGKmtG3YIxEskz9uEghs1Sk+TsPZw==
X-Received: by 2002:a05:6512:b8e:b0:536:55a9:4b6c with SMTP id 2adb3069b0e04-53678fbb03fmr9060454e87.13.1726494891548;
        Mon, 16 Sep 2024 06:54:51 -0700 (PDT)
Received: from pc636 (host-95-194-217-125.mobileonline.telia.com. [95.194.217.125])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5368704677fsm883002e87.36.2024.09.16.06.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 06:54:50 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 16 Sep 2024 15:54:45 +0200
To: Juefei Pu <juefei.pu@email.ucr.edu>
Cc: Xingyu Li <xli399@ucr.edu>, Uladzislau Rezki <urezki@gmail.com>,
	paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org, josh@joshtriplett.org, boqun.feng@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com, qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yu Hao <yhao016@ucr.edu>
Subject: Re: BUG: WARNING in kvfree_rcu_bulk
Message-ID: <Zug4pQjdWtR0ToMn@pc636>
References: <CALAgD-7JNKw5m0wpGAN+ezCL-qn7LcTL5vgyBmQZKbf5BTNUCw@mail.gmail.com>
 <ZtAunXBPC4WElcez@pc636>
 <CALAgD-4kr9MLE6jSF7pXFX9msd-NWFL8mrscvJAOecNWAYL4RQ@mail.gmail.com>
 <ZtieQFsSiALVVGld@pc636>
 <CALAgD-7WAY6FwTNGdt0BQ2S99Nr+yJ5XyWhA_L_SsbkKsHBrFw@mail.gmail.com>
 <ZuMR_U5JfZTIeG30@pc636>
 <CALAgD-5-Y1S34XqqGkNaO-fFiYAFODkDGiDrshaVLxGLcAYvYQ@mail.gmail.com>
 <CANikGpd-rkQh8EpygeLxcHrO1r+72G2bHA_MQ2CFExDK_KDe_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANikGpd-rkQh8EpygeLxcHrO1r+72G2bHA_MQ2CFExDK_KDe_Q@mail.gmail.com>

> After several tests, I found that the same PoC can cause multiple
> different crashes for some unknown reason. Thus, I suspect that the
> bug is capable of performing unintended memory writing without being
> caught by KASAN.
> I tested the PoC on the latest kernel, Linux 6.11 rc7 and it can still
> cause crashes.
> For reproducibility, I've created a GitHub repo at
> https://github.com/TomAPU/Linux611BugReport, which contains the
> software versions we used, the QEMU arguments we used to boot up the
> kernel, the kernel config we used,  the pre-compiled kernel image,
> Dockerfile that can be used to compile the kernel.
> I hope this repo will be helpful for analyzing the bug.
> 
Could you please help to bisect this bug then?

Thanks!

--
Uladzislau Rezki
