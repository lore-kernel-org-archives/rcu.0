Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D800D4205A
	for <rcu@vger.kernel.org>; Fri,  1 Mar 2024 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709306014; cv=none; b=g+TOxz1s+35xgD+Vy73zH7Xh6+/VEKWmafggJ2ZNl5XWWRwfpeQsB3SgnXXtEVUCKwRai//0BBvIIJamfhOW/IESbEVksIbfJ4ORMRIBMpRgGY9IM7AxGoCLE8jQQt/3OzZdgsRb8OqlR4vOs68A+eWq40RKGrMrFaA8Is6QrTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709306014; c=relaxed/simple;
	bh=PebnkUuVTIKrTfkdeZeFzM4Bp/iInDLtHpeJBmzIpLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSlrrycScCO3cos0eIUph6mWMViRwqZrB8FnJ4buAMpBKFocFyh/X+c6Al35xcUBSVzPQM34yT4knOT2E8vFFu86VEr8KrwWToWsUxkPFEmenO6EFBLdNOdGBTU5u74wYeoZRJ41YcLr6BgGR01dEV+u6vgfb7csW0O8WlXTbJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Soh8tyeI; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Soh8tyeI"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3e550ef31cso324500366b.3
        for <rcu@vger.kernel.org>; Fri, 01 Mar 2024 07:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709306009; x=1709910809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HDkjb/3ycOtyX9DruBw4yM0aFf/SrD3+DOAhw0JNHrc=;
        b=Soh8tyeI0D7FXPUk4acDygDR8rdIBeb6zQgZTzYXsTP7oHd5AEwkoA4fWYOUQgUdfe
         RvVvvfnsYMZyj06Z7dVxBLTznRdBjoNXbuwLuiF0gsdmX/6p/aBaZmluF+UkXFT2p8Sy
         5Vjmv/wbIwUnlKFXmibUeHY3f6i+oJvVIPZfFQ2j5LOiR9PUlJM/xI6ILnZg+OZ699dv
         ZUQsX1x7f0dvbua260VRBrkS5tDYm1fEzSe87ahz8ZpyTJg0QajpIKYeKg/FH4yZuN4/
         lCo9LjBN4t8VP3DGZARGtdNM5LLB6vgNvNnObjyaE70RCqUYRwWnbxsIwi7xTnYGPU66
         CfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709306009; x=1709910809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDkjb/3ycOtyX9DruBw4yM0aFf/SrD3+DOAhw0JNHrc=;
        b=Qymyxz49xgRnwtfA1IWQNn0nsp3zwwxJpZy2qxvXm0eu1Lu65fzV/3jPW//csdCxzX
         vyy/fUKU2G+ntpSFd6rAnx+dP7ZrJEB4XhUBAZhvczUT4G7eLtx7aHK8FE5TO+fm3CMU
         XVwq+wIGD7G3tSWR2J8kcN4m/49NgWkDPmXHycyWuVE2ZoXuSFbg3M/0dJd3SevyPi4t
         4h8MqmDjsmJPkj24pPiCX/nw2LHFKYKCB5sV5ZUuGLMyNkTgRpUrk0M+DaawQalPby3O
         TPTRGWyoQ20oIFa3xPtPWP+ccBOXIX3Jb3h4/yZzhDMtbx4P3YKOW/a19VEdL6X19KL3
         Wh8w==
X-Forwarded-Encrypted: i=1; AJvYcCUw8ZUCoNCg9Rn5krhpxQ0iS+sR4cldMTC1XRDuT7yR3jNO0PuAnLtobCyPCGEtEkJov6/RmIf26ofu4rf80FZ7EJik
X-Gm-Message-State: AOJu0YwsjvUsz8JDHlz2Cb01/Bj2RMxXOfVDeXdoB3D96pMPZhJsCsPl
	Ar/1Aw5vG5clPmMkGof56haxafOWS8gwCxl+c86Iz1ikVE09dWKNpwQaSmOgtMU=
X-Google-Smtp-Source: AGHT+IFTY55Wj25m0rpyyfxtHm3gpdleYksn/7veTld3RUy8XLWRBDSXZuFQrny/q9cL7tsHEE6O/g==
X-Received: by 2002:a17:906:6ac7:b0:a44:9aea:779f with SMTP id q7-20020a1709066ac700b00a449aea779fmr1132507ejs.44.1709306009182;
        Fri, 01 Mar 2024 07:13:29 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id le6-20020a170906ae0600b00a449b4f4aefsm488987ejb.178.2024.03.01.07.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 07:13:28 -0800 (PST)
Date: Fri, 1 Mar 2024 16:13:27 +0100
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
Subject: Re: [PATCH printk v2 25/26] rcu: Mark emergency section in rcu stalls
Message-ID: <ZeHwl63uXDZ9ZBtt@alley>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
 <20240218185726.1994771-26-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218185726.1994771-26-john.ogness@linutronix.de>

On Sun 2024-02-18 20:03:25, John Ogness wrote:
> Mark an emergency section within print_other_cpu_stall(), where
> RCU stall information is printed. In this section, the CPU will
> not perform console output for the printk() calls. Instead, a
> flushing of the console output is triggered when exiting the
> emergency section.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

I was just curious about one thing. But it seems to work well.

print_other_cpu_stall() print backtraces on other CPUs via NMI.
The other CPUs would not see the emergency context. They would
call defer_console_output() because they are in NMI. As a result:

  + Legacy consoles might be flushed on other CPUs even before
    nbcon_cpu_emergency_exit() gets called.

  + nbcon consoles might still be flushed by the printk kthread
    until all messages get flushed directly by nbcon_cpu_emergency_exit()

As I wrote. The behavior is corrent. It was just not obvious to me.


> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -9,6 +9,7 @@
>  
>  #include <linux/kvm_para.h>
>  #include <linux/rcu_notifier.h>
> +#include <linux/console.h>
>  
>  //////////////////////////////////////////////////////////////////////////////
>  //
> @@ -604,6 +605,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
>  	if (rcu_stall_is_suppressed())
>  		return;
>  
> +	nbcon_cpu_emergency_enter();
> +
>  	/*
>  	 * OK, time to rat on our buddy...
>  	 * See Documentation/RCU/stallwarn.rst for info on how to debug
> @@ -658,6 +661,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
>  	panic_on_rcu_stall();
>  
>  	rcu_force_quiescent_state();  /* Kick them all. */
> +
> +	nbcon_cpu_emergency_exit();
>  }
>  
>  static void print_cpu_stall(unsigned long gps)

Best Regards,
Petr
