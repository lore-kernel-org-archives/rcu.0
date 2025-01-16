Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF003BBC5;
	Thu, 16 Jan 2025 14:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737036245; cv=none; b=KiHK1tIKFfuzWPCjNnn03yV79dt6sJmamgNGT2eusutn7MbjdYaLlVNhxHV9oV5KNUphCglUGkGyt35tiEhEpkFrNv+sFOPQ161pQJr6jx372lz3okZGKkrVoqkGY8ckgo5wF2+wiH5UJ1LDOzEx48EZUbdPzfVYt9fZzXmSjX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737036245; c=relaxed/simple;
	bh=aumlo1hSv1RGq++VrDnHs0vxHWrKksh1sRvk0Ro45nE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIbxHAMEsyqmspkVOtyfMsz0oYQR6yTYkwVELcxKZtjjO+UTV3kKPQvhza3rdNJH88RsyWVzSU8H1HcpOvkW7zdWkhosKWoZm8DAvnL7ffStETZJk5nnwbQagmBHXEm8xlpLWUhaW88Edgj1UeMimDRvjp09N9MkHunD/F23RXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hp+9kGl/; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hp+9kGl/"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53ffaaeeb76so1013733e87.0;
        Thu, 16 Jan 2025 06:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737036242; x=1737641042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N/RtX+cgcWKj9zjY7fDNFiaiGMxyIrenboTJKW5OkPY=;
        b=hp+9kGl/Q7wl2GO80T+5g1loYmDJpH5fE8ZCHfOEoRtkblliq8EMG9K55bwruPoUxU
         iy9mb8G3PfQabtd6wpMMgGQJR3IPWlaVhQSDu/P+JVGFP/RHHNUI+LoGJH4CKpsBifH1
         fvqanXbYEzvXlhYOoN6FMFwuhVGf2P8FA9hUI8Ldj9HWCdT/jSQ6mDuObqNzjw9l+BAG
         dLSn6Bl1FJ9MJ0qxvqFVATLqy4Ei+0p+sRub2BpIv3ztxFcKJhCOPLH9wPDJDMB99/RV
         4KH72inLTm07lBZFPGLlubiBI95uzRuyoshtWsOBKi+RMY9sJ1FZXKbEXB39T/sUIlNF
         wqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737036242; x=1737641042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/RtX+cgcWKj9zjY7fDNFiaiGMxyIrenboTJKW5OkPY=;
        b=h0meNXQte0b7srTgDmGkH0e/wcBouWACB1WirdrcRWroqDONJ+qj4B+ZFNrWUBniTd
         AZMMbMMi3kj9AzkRsARIe5p4Xrk3ojJOrTnCTYuoKJIx/5R5NGCAy4Qnbt6Mlt/dveOg
         hBHnZVDvDXztL0F47C0U262/WpoeSW4UbZz51tKoxJLF1RT/fYtPqGUGz3+p6f4I2UoY
         rDzrpwxAlc9PbAUyA6yfdduI1PC+auXEfqcOuZWIaT2h+bYNoAvzZnU9Y8WZfiWQ/L/a
         VKIzSmUElYcUNmFZJg7fVD9avjUr5GSgDi/dsNNDjS8+QE0qBAzN76vNhHtDH5Ch8jK+
         tUlg==
X-Forwarded-Encrypted: i=1; AJvYcCWJzWM7SHsk/rqLEodWUaS7cNLXdBY/GhFnnVprc80A2L9TPEU3CbdseS3upGpJlyLTJ9iY@vger.kernel.org, AJvYcCWze/Y+fW9qzEIp/JMRwjQhIA8S3XKlRyuqDTz36/U3QT5IdEi0t6CJFQhohCejjpMfYT5k06tDeR3rFEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnh3F0OXYtuBRWdZkBo0HMcTml/M+KvowYCUi6prTqhqaBIKd4
	40lr3PPSw8Uene0iH9opdJyv6RjjKlZVhAGEh6tYis88RiDz/ED+
X-Gm-Gg: ASbGncv4/Ifn3ZXB3rbXrQSA0rvV0607px8QUmSAt0uG7864n3nA0UQKwpGorIdy6MU
	a2P08XJ8nzjPL9U6IV6UAgz6pMwOZ489s3qz3OQXoimjpl3UpV2eN/q4O1IIILyoBRtIIgAKXYk
	rHH6194qeLaz/Jm6t6dVvVxKJA1HfgoP1bymgiS2lsjyngT7jbHdpx7SUaxbRTVuwZGIC2t+lis
	bFLRz7oZmmuBZ2hVuEhUJFfO2MvM8LgcwB5e8tGGZvTWZfYHyG7MKzNACbkvPuj40+NHnlj19Zf
	CMSez2sIQoI=
X-Google-Smtp-Source: AGHT+IG91kg2Z0+xyGHOZeIUOyhQvY89VqnIW114qF8zIlOdtY6mDgWmurCfZRMfTBDmsmgFEOpGQQ==
X-Received: by 2002:a05:6512:15a3:b0:542:2f5a:5f52 with SMTP id 2adb3069b0e04-542845b9037mr9895397e87.13.1737036240363;
        Thu, 16 Jan 2025 06:04:00 -0800 (PST)
Received: from pc636 (host-217-213-93-172.mobileonline.telia.com. [217.213.93.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5428becbbf4sm2312143e87.256.2025.01.16.06.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 06:03:59 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 16 Jan 2025 15:03:56 +0100
To: cheung wall <zzqq0103.hey@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: "WARNING in rcu_sr_normal_complete" in Linux Kernel v6.12-rc4
Message-ID: <Z4kRzMO03mwjqCu2@pc636>
References: <CAKHoSAvbRnktnM=H52eNe0QQryP908Q612Hfxzy2sozUdHRrjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHoSAvbRnktnM=H52eNe0QQryP908Q612Hfxzy2sozUdHRrjQ@mail.gmail.com>

Hello, Cheung Wall!

> 
> I am writing to report a potential vulnerability identified in the
> Linux Kernel version v6.12-rc4. This vulnerability was discovered
> while i was testing the kernel.
> 
> Linux Kernel Repository Git Commit:
> 42f7652d3eb527d03665b09edac47f85fb600924 (tag: v6.12-rc4)
> 
> Bug Location: 0010:rcu_sr_normal_complete+0xd0/0x110 kernel/rcu/tree.c:1638
> 
> Bug report: https://pastebin.com/kuJ7wnPe
> 
> Entire Log: https://pastebin.com/fT42ya0T
> 
> Thank you for your time and attention.
> 
Do you have a reproducer of this splat?

Thank you in advance!

--
Uladzislau Rezki
