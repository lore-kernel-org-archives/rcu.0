Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4623D3FE36A
	for <rcu@vger.kernel.org>; Wed,  6 May 2026 10:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778062699; cv=none; b=cSylzHwiaU1W2pfG9hCnNjSql+wj4Uz4BDyCpH4q4v66RoQwAILaffXrTvnBh3S9FSB1pvw4WER0mzfxEy5uA1iC5ENXumACOwNrNyYlSHCGhMZU2vPIl1sYWE53F84TXhhdc+wTJDIhNX800J5/XknRJGiOipr0vW9GIagL+Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778062699; c=relaxed/simple;
	bh=11SWNtf3rfJVUf5eCd4VWE6+WLjXa5rsIqGFz+UaHxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSsJMk0iwX4gqnbJg8+nRQToPy16FXJwF8b9YoS+4c42mAilIPi+yHmuSViO0K+D2MnQRXqrC9Lh6lwKmviTgStp74ncash3xDTyfVCCai+s3BQuyZ0hO6uKKpkNlZqi+3PBcj8MC3KweUC7SbJlnbm9vC+d9yhJ7BdKmepoEik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBzHeSdR; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBzHeSdR"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c80291e6237so2209560a12.0
        for <rcu@vger.kernel.org>; Wed, 06 May 2026 03:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778062696; x=1778667496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mDZ4pUw0CX7S4gau2UFJHmOf0T1JHQBK6QOlQZ991TU=;
        b=dBzHeSdRjSPjqxelyFbXLhmkaBt8GlC+SdLcE1JJnRY1PFgRt8qeqTMpWofY2LNML/
         seX296K3XA0Hwmy6BpafYmcdq4u3LI3LayVPZL2dbnLW1ASsigi+z+t5YwjeYfl4jkY6
         BDskQCFO+PKt9gyRRdCJpRIeErasIQGKTx52DKq6wrFmMWHfFjiXlEtsmIzwMKpkAOv8
         uYepnnpzLjqzwzu/Sh02dRwruA7i4bnc7EP7qYiVplVvmZtOOaarCtzkCh/glYl4Wwaf
         8dnujaP6Fmmt2u2OpEzHc6Ie7KCsW4uyYAytO3RT8c8lzX2lAmHxbaznMgpisYzAKnlM
         aL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778062696; x=1778667496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDZ4pUw0CX7S4gau2UFJHmOf0T1JHQBK6QOlQZ991TU=;
        b=BCBzw50pSNOZXTMjCn3sLmxvNer8cK5SOFcJ0U1tBPRurv/dX3rPVqqSas74zoaMSq
         bB8BipeuSj6WDf4jN4uzQMkm2b+kCmSTV84xNMuD4OyYum5ed97HJeNZV9gDrKKGGv25
         FaJludv5Ivi8tqMQBZmVUPxhwdtLBxsPiluyfSNDt4MjhBYw8EVrPGfWvo5U8D2U2bmz
         Zb5B9O7XNmEY8PVUXDW8+DZlieKx1uQMpmmccN4VxhSQL12XPL49ksxcL6nGGuLchyD1
         SyF0XNdyHNPITMZj2g1Hs6OK7Rk2F954I0cJEzDUqlRAVCRAhyC9ADediW2dPC7xKPOg
         VcwQ==
X-Forwarded-Encrypted: i=1; AFNElJ9aN3Cz9QZ5k03L8aXLhaJuwsEqUEmnbhKpPXRrsW8O56eYxY74mpf5Ahennw8WPtdvyFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+yL481Dv30ITL6Bg4FHq0/te5jK0PCXMvZIKt24mlrziVBS9x
	gCQWaaumBJoZPzDdC165iFgtgWWXFeSV15jNirIp/DLQ4skO8ux+M4q7
X-Gm-Gg: AeBDieuahAVCxtlFyvvy8fg8Vt1502SbgqlTc6AqjzqOY8K0t4HOrqTC243tsCZVFIZ
	c3X32r5KWWH46ei97YkGUynhivroqhuVqrILU34UjPtvw/EF6RFJswMYRnK2GPjKeb07IagXUBU
	GjV4D9L+bIPk5Yz3FawEyeNzLUHipNNSOzoijV7JuXRfZmHckUi0zSnbeTan+VDjaPABk+Rp+me
	8giItoV5jcZhWjuwcLn9PmHhhoEMoMlYDPElZfjwjf9WJb17iRLTvI5YvLJ5fT+FCTgk269pFCy
	W1gI5im8USs1r4JPd2p6Y7taZ+S8jbJOXKRmkUvRIdD2L+gsq48T6ctZJmA8Gjju5MG9zrTSb6M
	GUAnYCGJSmnFIBrcEEYIsDAgpII3U9AmjR6u7gWraq9piPtjOhyfJrvILTW37+0xdHPARVIZIQB
	EIWm625BE/4cjTRAa98/YNWp4TO+osA2scMmaFZxMpfDKI5PLAvIxwpoFqyBbfesC2SbUuA1Uq9
	Le1JWPuHRHr8Enh
X-Received: by 2002:a05:6a20:549d:b0:3a0:b781:4c78 with SMTP id adf61e73a8af0-3aa5a8fa74emr3005470637.15.1778062695961;
        Wed, 06 May 2026 03:18:15 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-99-238.dynamic-ip.hinet.net. [36.225.99.238])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8242cc1768sm1804956a12.32.2026.05.06.03.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 03:18:15 -0700 (PDT)
Date: Wed, 6 May 2026 18:18:11 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, sched-ext@lists.linux.dev, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, rcu@vger.kernel.org, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v2 2/2] sched_ext: Fix exit_cpu accuracy for lockup paths
Message-ID: <20260506181409.Gc6e5@cchengyang.duckdns.org>
References: <20260504161543.674488-1-yphbchou0911@gmail.com>
 <20260504161543.674488-3-yphbchou0911@gmail.com>
 <c402160a-dbc6-4292-a684-395a80d677d4@paulmck-laptop>
 <20260505154006.G743b@cchengyang.duckdns.org>
 <afmrgVdEHKF0FbNs@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afmrgVdEHKF0FbNs@slm.duckdns.org>

Hi Tejun,

On Mon, May 04, 2026 at 10:34:09PM -1000, Tejun Heo wrote:
> On Tue, May 05, 2026 at 04:20:25PM +0800, Cheng-Yang Chou wrote:
> ...
> > > There might be more than one stalled CPU.  You could pass in a cpumask_t
> > > or similar to print all of them, or take the first or the last or
> > > some such.
> > 
> > sched_ext's exit_info carries a single s32 exit_cpu, so we can only
> > record one CPU. Would taking the first stalled CPU be acceptable as a 
> > best-effort hint, or would you prefer we pass -1 and skip the CPU field
> > entirely for the RCU stall paths?
> 
> We carry only one cpu in exit_info but we can easily dump the cpumask and
> prioritize dumping all the cpus in the mask.

To confirm: are you suggesting scx_rcu_cpu_stall() take a cpumask, use
cpumask_first() for exit_cpu, and dump the full mask in the exit message?

Thanks.

-- 
Cheers,
Cheng-Yang
