Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE55114E2DB
	for <rcu@vger.kernel.org>; Tue, 28 May 2024 10:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716890655; cv=none; b=pFQdwIx1GHS0fnAvYAklRll1nD/6jPm0xx/ENEBiNV1I1JIks8by6EhG5hfe7f6Ija35RptXbguQVrG/1CELCYTojSGVm4kxJZd1KGFbmbtcty7wMDI68rUcfHS7oS/Gmg0g7B8IOZc/rNHIOrLXC/epVjo4RVTNMwYY8ub4M3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716890655; c=relaxed/simple;
	bh=1yEvxg/UMf7DXoCsSdoVaI8TMmEaatz23H4XZLpBSjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pjxa2HzqNjubG8sENZd8V63B92VOYFc+yj4zJgLXOSgbCnExiP5o04489x1M1q/OIN628IMFTLQKj3qhLIgaL1hAX04EG0aHfzYdzAWOHUmHE5JlSHZdn4yTPGs8N1ZDZCKQTbD6+0N5wqBRtF9u6OBKwfl/wf5PipfLTwoSlMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bvOIUnGL; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bvOIUnGL"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57857e0f45dso719352a12.1
        for <rcu@vger.kernel.org>; Tue, 28 May 2024 03:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716890651; x=1717495451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zuLcdpryWUXbu5ak1d/oYJThVncqY5Jd7DeWCPAKJnY=;
        b=bvOIUnGLgHpa9sx5dl9A/ko8z7FDaT8PyYc+cF9O1rQF7RUSp8l2QiQtxbQNT4IHj0
         9M/a8Di2H+eH6FMTKWQDT06oNocUyHlTvPMoufo671T72Tz1cNPCPCKvNgUZLsBX3Bix
         9gSHTc7pZ20du1PwK3fOEKWTQgSWqnz/R440617ohHE6NrBLGOtQ/Qd0ruc7qPmIcq7J
         Imh/Ou2HLsKM/yeDrNd+uS0UkiBncC5OatcfjCDqV6yDyaBzY/2rjDgsGTS+XmQFfGdQ
         nprb/w+b7QNSa1IYJ0XVy42rnOBAz/TzeyStbSq97VLXpTCzFzDWyIIg8Yx0/QuiW2eB
         yrOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716890651; x=1717495451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuLcdpryWUXbu5ak1d/oYJThVncqY5Jd7DeWCPAKJnY=;
        b=SOdF1wjyoZRiWaoLGS1MMbgF6stncWaT6ZzTV8MF3ZXmMwrjzcolx2kZS0XpkMA1oV
         UDkZRhX6UxU+k1NvRenrNlVxpRO1W3/nzqB3q33JWQV5BJFodeKvFZrSsyYTdPEh+t6s
         BtTAYzg5rJOb2KuBgSI9wpY7dzs2FVn+EKik2GGlGdhcjxxVQlUoui1o4dL6SdBWDWeD
         0u6pDDOZwNtWmMr8DYwICmFC2tdymZ87yzeu3bY0UKRc2YK2yPKWtdFt1UxoEmVqvs8+
         IpJkK4AzOpj/+TyywWAtRBLFPr6gyANnlHaa9C9sE8xNk6aU5tzg/U6/tG8TnTCXI4Yu
         YRNA==
X-Forwarded-Encrypted: i=1; AJvYcCVP8itAex8ZCrgLuzNhAx+zHyxRBR5INIW/z7VN0hX0ZY0IV8W5bD1HzanTk1j3euHJSKy1xegZeWZImVieLjNu2B7M
X-Gm-Message-State: AOJu0YzGLGqQCo6IT2lOCFnOhfaim1tKLvJto9BD6K3p+Vu7yWkjskCT
	4MY2HTvVMpC8ZEqoI7yB1NtXzpCdHR2mKkgIyCOFmZewo0otUFojVZ05XRRQShs=
X-Google-Smtp-Source: AGHT+IHStxBPW+RVZLC/cBlGPEigVgucOLaLZJoJjANp3IgFGqIqy41pQ1K2ZkdhIo3YDJ5C/j8z/g==
X-Received: by 2002:a50:d789:0:b0:572:4041:5637 with SMTP id 4fb4d7f45d1cf-5785199d663mr7353637a12.19.1716890651285;
        Tue, 28 May 2024 03:04:11 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57852339fc4sm6975423a12.15.2024.05.28.03.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 03:04:11 -0700 (PDT)
Date: Tue, 28 May 2024 12:04:09 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH printk v6 29/30] rcu: Mark emergency sections in rcu
 stalls
Message-ID: <ZlWsGd7ajyrlK-cB@pathway.suse.cz>
References: <20240527063749.391035-1-john.ogness@linutronix.de>
 <20240527063749.391035-30-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527063749.391035-30-john.ogness@linutronix.de>

On Mon 2024-05-27 08:43:48, John Ogness wrote:
> Mark emergency sections wherever multiple lines of
> rcu stall information are generated. In an emergency
> section the CPU will not perform console output for the
> printk() calls. Instead, a flushing of the console
> output is triggered when exiting the emergency section.
> This allows the full message block to be stored as
> quickly as possible in the ringbuffer.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
