Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DF44778C;
	Wed,  4 Sep 2024 17:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725472327; cv=none; b=mi+WI8xV9qXG3rfxc6wh3PU7pO1sEcm44KrPtIS7sxqsT7QeCD9dzGvUOdWhf1C1t6oU187o53beb5x18bVWKLs1NGxMhjsPrgmDbJihAXWkx7ZA9kygI4gML2oa2liUFsh4dwD/sitwdxfdc8vL1IkeLL7QpYqpx+CKcucJ298=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725472327; c=relaxed/simple;
	bh=YGPraftcRKoUXwmDO7A034tijjCaw06B+EsJ6AUIBNc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l68nOILYDwns1AYWCqhq7UdG5UN9zfZvgkL4tBnnrh093rFCRcOd25ZmILExC01FZXqtddoogoN8xEu+y33f0OoVm3VqWZYLLt33Oz3dIs9KdjuJnwqj6W80wosssITx7R1lIfNCtQU/Qy8aBqFhQpNTo+tBUUGEjm79FXqUK9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnwLu/pY; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnwLu/pY"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f6514f23b6so21466111fa.1;
        Wed, 04 Sep 2024 10:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725472324; x=1726077124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=InAq5n71slwXeqxP3KBnSK24bt4N3NVLz7CRiZbko1k=;
        b=LnwLu/pYC/IBp/F4ARkkrD7AI5X4p8acckdpL+taZZ2OYhC/t8g9+ohBqX8PVkSw8s
         IdzOQF9MplhN/Qfcdz89g6neY8Oe5OzHkz4OXdLzUi9Yg/4bPoIcHwEkQNoDyr794cuP
         e977JSV6GWrMzsyTPcQVXJ2ScULhIhyzBsl3M6qbdaXaNIXf3chYPAdDfdg3Vdoemx2a
         VI9QF/xP2Lj4YB03u2z4VYypceBMKTrSeB7wT4kHv4TPSav3zwIlLHeVV7PJs/Vj0SSG
         U354En+con0OwYDiScpKgIo3lUmEwvWfJFoWsb4AqofA2m7dgKiyAugy7er4MsiUeFxJ
         /fYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725472324; x=1726077124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InAq5n71slwXeqxP3KBnSK24bt4N3NVLz7CRiZbko1k=;
        b=E16uHXK5uqO70jE6EQar9tXgZJbOzz1UTky+87oIEuhqTWxIXyYY1ly29rTg1XH8Ri
         GcInfqBZI7mJxK+i9HfTH1klF/PsOx3rzY4bWJvMGyMFgwGPiRlEluGhNJOLdbxF0sK1
         t7lW0UV/C8OA5L0E7kczv5wVN5fRDlY5J02hKX8WRB5Stk48V8kZyhprTf/XjaMxul4U
         DBELJXYzodI38UN6xSPWBrljGmQN5LflbKBd0TlETZnK9dGBSxmNEEiFyNIgbf648m0G
         PSlvSRz2j2qOEoAdHU8ewpdY10gFRsrkP9Og8rS0XGC7LGCV45He0N2/LloPYhk71Ugh
         rYew==
X-Forwarded-Encrypted: i=1; AJvYcCVfQzW0BVo1YGMbWJClSgTMoDpmD7rKteIN4819tl+B2DW3CdS967eYOBpExiOD/HlUcOMr@vger.kernel.org, AJvYcCXMizdmoeqq5Dtnns4BGr7+LCLAhE3cuat1oH+SZZSelyJHIUUKulYChr7RDv9zmOd6t0EZZn/vIbK2Oug=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCxFnSHM3lu+qaUiel0/sfPxeOhHzskGITIlOnvMqtEGMCHQ8D
	yq1c2r3uUTTnsaRk3zSYwQzLtVDcY63DJFtAkCXZWXwG4EjiCYhE
X-Google-Smtp-Source: AGHT+IEwEkiLdnz1yLd7itMz4Si8sdSPOfOM39CzoEUEW1cu0bt+uqw3ZVzS1TrU0yY4BbQVSu4LLw==
X-Received: by 2002:a05:6512:1048:b0:530:da96:a990 with SMTP id 2adb3069b0e04-53546b5988fmr15139183e87.32.1725472323930;
        Wed, 04 Sep 2024 10:52:03 -0700 (PDT)
Received: from pc636 (host-90-235-20-248.mobileonline.telia.com. [90.235.20.248])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5354084dfc3sm2416779e87.269.2024.09.04.10.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 10:52:03 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 4 Sep 2024 19:52:00 +0200
To: Xingyu Li <xli399@ucr.edu>
Cc: Uladzislau Rezki <urezki@gmail.com>, paulmck@kernel.org,
	frederic@kernel.org, neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org, josh@joshtriplett.org, boqun.feng@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com, qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yu Hao <yhao016@ucr.edu>
Subject: Re: BUG: WARNING in kvfree_rcu_bulk
Message-ID: <ZtieQFsSiALVVGld@pc636>
References: <CALAgD-7JNKw5m0wpGAN+ezCL-qn7LcTL5vgyBmQZKbf5BTNUCw@mail.gmail.com>
 <ZtAunXBPC4WElcez@pc636>
 <CALAgD-4kr9MLE6jSF7pXFX9msd-NWFL8mrscvJAOecNWAYL4RQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAgD-4kr9MLE6jSF7pXFX9msd-NWFL8mrscvJAOecNWAYL4RQ@mail.gmail.com>

Hello!

>
> Here is the config file:
> https://gist.github.com/TomAPU/64f5db0fe976a3e94a6dd2b621887cdd
> 
Thank you. I was not able to boot my box using your config file. But i
enabled all needed configs in to run your reproduce so it does not
complain on below warnings:

<snip>
urezki@pc638:~$ sudo ./a.out
the reproducer may not work as expected: USB injection setup failed: failed to chmod /dev/raw-gadget
the reproducer may not work as expected: 802154 injection setup failed: netlink_query_family_id failed
<snip>

sudo modprobe raw_gadget 
sudo modprobe ieee802154
sudo modprobe ieee802154_socket 
sudo modprobe hci
sudo modprobe hci_vhci 
sudo modprobe mac802154
sudo modprobe ieee802154
sudo modprobe ieee802154_socket
sudo modprobe mac802154_hwsim
sudo modprobe adf7242
sudo modprobe atusb
sudo modprobe at86rf230
sudo modprobe fakelb
sudo modprobe mrf24j40
sudo modprobe cc2520

and even after that i am not able to get any "WARNING in kvfree_rcu_bulk".

urezki@pc638:~$ uname -a
Linux pc638 6.11.0-rc2+ #3827 SMP PREEMPT_DYNAMIC Wed Sep  4 19:37:22 CEST 2024 x86_64 GNU/Linux
urezki@pc638:~$

is it easy to reproduce? Am i missing something in my setup?

--
Uladzislau Rezki
