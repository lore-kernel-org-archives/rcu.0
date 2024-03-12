Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4B4143C4A
	for <rcu@vger.kernel.org>; Tue, 12 Mar 2024 21:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710279877; cv=none; b=U7Z3l3eQ6wfjNX4R30/lkedicJ/T9PQQT1ARP/zTAsw3lGko5cL1yrddd6JhWSmKiBEfH0WnaL6OthR2rMdhRz1ihRG6VkgQX+nii8x5NipdE4NXqi/CqZwOvvHxBfpqjkvylHUX57/hxUlK3B8sNdgk1j8bADR0y7Izp3jrg2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710279877; c=relaxed/simple;
	bh=XwiL2+kAZDq+JSypY/KCkgWIbQMNeeVzIuxHI5gIcF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pIPWq/xV85XO/Q4vm+ir8OtIGJ6VpqIF4g3zgnp5kIIcUTpz7YhNIVfFgne6jm9nscLjSnhTJ61hS+J6iKDi46bqKUSJj/kjygGtWJpcaC9enjPBoyrpN4ifXLGCOry3xL3RLIp6rfq6deN7anELQkFMiQyIu1G/gKORinj8fJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KKRfRaWe; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KKRfRaWe"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5135486cfccso5908742e87.0
        for <rcu@vger.kernel.org>; Tue, 12 Mar 2024 14:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710279873; x=1710884673; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+QBam0nDIK6OKPia5iCGv4lhBlNNZUHT9InuuVs5DM8=;
        b=KKRfRaWeA6WSJdE01jClK/UZ9c6TbaidThWmnu5tE+bYqU3vaT19gg9q1g4EBuR2hW
         PfrPpUU+cHjfITAphWWvAg/c2+9qxtNLlhQPJHmt0MoogdJ5WuLTFrkz3WbcTb0nRtCo
         PX7RvAUAW8e2nmLuUzA2wIYw+qss/+WxynHU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710279873; x=1710884673;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+QBam0nDIK6OKPia5iCGv4lhBlNNZUHT9InuuVs5DM8=;
        b=XgXB21oR4OUA0FFdXUhngAVwoHaH57PlWuRcf75kq5knubAJB4vl23bmMbCzTHMZR5
         MB9FMaidKKZNqDQu76IdEaoeryK0pxYKcpVJJtQCb0DCDjDxFt4OAzPm10TDDj/Rj8B7
         8/TLz9iBWbt+cQTDSE2K0lDk5YTW5VCLl4Tkp9kTdBcQjYo5bxRKzjAjg5Aok2H/IhMK
         pv9Jp0yDpCY8ZGGhVgSU2Ogg0demMx/6Kh1CTyQbYbpqqgCSnZ9n8dwsO1wFqA4QKSCb
         eRuULWIcNPbfCbVbcGEjqtJeHCBNa7z5GMhpAdDDwLcQdDdhVp0ktOiob2HP4fXCULoE
         eeRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCFEurRFP8quiyLl6vKdETlObLeRizBOfQAkbWX61q1JfQhrTDD9Yo1onwwpK/byIKkDQ8IvEVZwPcDCToFsduykts
X-Gm-Message-State: AOJu0Yx3VEDHmrkHBQw4p5FxUeKAW20KyI3/saz7cpmAMBgqyyd2i7z+
	bmdeeItuMXHLTxIjX5P9R/KMkU2OgWsDUN3oyluGhw2UKdogj37J2t51/vOKRqKaUMYKA3526wo
	vYYAGpA==
X-Google-Smtp-Source: AGHT+IG0c8E3qYP1lRjVTj82DLPTm2hkROsFD/8mbIMNH7CADi5AnP4ovcof9wadHYZQAdUdC0Zs2g==
X-Received: by 2002:a19:9154:0:b0:513:9dba:f32e with SMTP id y20-20020a199154000000b005139dbaf32emr6723830lfj.20.1710279873253;
        Tue, 12 Mar 2024 14:44:33 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id r10-20020ac25a4a000000b005132bf49f99sm1708474lfn.140.2024.03.12.14.44.30
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 14:44:31 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d3b93e992aso57705071fa.1
        for <rcu@vger.kernel.org>; Tue, 12 Mar 2024 14:44:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWlFyLhGW1sfK2C4PiTKoO8R8gJpersWK+8C9d5IYog3OdfcDlXc8g+3rOlLE/fUjSewVutoL9ESa0LjlvZtzddNGHn
X-Received: by 2002:ac2:484a:0:b0:513:5a38:f545 with SMTP id
 10-20020ac2484a000000b005135a38f545mr8283446lfy.62.1710279870592; Tue, 12 Mar
 2024 14:44:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZetHwrCb0KXE0xFI@tardis> <4274be61-60bd-4e1e-9c16-26e6e5e06f65@gmail.com>
 <ZfDEIs63EBIYBJIC@boqun-archlinux> <c5f9c640-4c06-495e-9c7e-0c208b914fa7@gmail.com>
In-Reply-To: <c5f9c640-4c06-495e-9c7e-0c208b914fa7@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Mar 2024 14:44:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgP=9JxdOJ5oYtVO5yM6pFi5+3FPxfCQa4ezpagJuXq3g@mail.gmail.com>
Message-ID: <CAHk-=wgP=9JxdOJ5oYtVO5yM6pFi5+3FPxfCQa4ezpagJuXq3g@mail.gmail.com>
Subject: Re: Unexplained long boot delays [Was Re: [GIT PULL] RCU changes for v6.9]
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, paulmck@kernel.org, mingo@kernel.org, 
	tglx@linutronix.de, rcu@vger.kernel.org, joel@joelfernandes.org, 
	neeraj.upadhyay@amd.com, urezki@gmail.com, qiang.zhang1211@gmail.com, 
	frederic@kernel.org, bigeasy@linutronix.de, anna-maria@linutronix.de, 
	chenzhongjin@huawei.com, yangjihong1@huawei.com, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Mar 2024 at 14:34, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> and here is a log where this fails:
>
> https://gist.github.com/ffainelli/ed08a2b3e853f59343786ebd20364fc8

You could try the 'initcall_debug' kernel command line.

It will make the above *much* noisier, but it might - thanks to all
the new noise - show exactly *what* is being crazy slow to initialize.

Because right now it's just radio silence in between those

  [    1.926435] bcmgenet f0480000.ethernet: GENET 5.0 EPHY: 0x0000
  [  162.148135] unimac-mdio unimac-mdio.0: Broadcom UniMAC MDIO bus

things, and that's presumably because some random initcall there just
takes forever to time out.

             Linus
