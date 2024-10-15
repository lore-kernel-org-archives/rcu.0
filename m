Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D192036F1
	for <rcu@vger.kernel.org>; Tue, 15 Oct 2024 18:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729018151; cv=none; b=mLZYMYBwM5i8GmLoxwg7ru4WWg4OsYQkajI5t/+v+rF9/LWu2tnGM7OERQ3vMHCRohAiNA9DdloGIfJp7Oh/hdfApu2603ggKg2g52E+6QMJxps6VAG9gORfUEjTA0LTC4b1HnvoTst/jwAeD6OUS6tmjfo6k4Kpux2SeDUEybk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729018151; c=relaxed/simple;
	bh=5QWkjiBOK8vQBcoN4bua4SiJxDMOxPdzdnn5cB9gR/g=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdYi5DxSBc0EiT8w5octCSW6qdi3GcRt7CCyYbK5uIF87n0EdWO/i5UrVNFvm/PnMbdXAyNKVTyKrJW25SeIl+jfMJQP7hZ0Nr0OGhnNvtoQN/HmM4BqbYnlg03h9CkI9A8KP1DNxlYP9sybJDzBy/USaJMY906ubm5sYwsLkGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=DQK+joN3; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="DQK+joN3"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4a46fc2d520so1186770137.3
        for <rcu@vger.kernel.org>; Tue, 15 Oct 2024 11:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1729018149; x=1729622949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NpvuM5Eyhl8BJ2Y8j5Ka7XYXyhujmAW/1IATRx+jU5c=;
        b=DQK+joN3f5jQU5UTFVcSf+og8INQt+kaEcf4T/UcNQGA/GXeXCg/F4Ef9aoOXy0hZ6
         WPa4zgtw9ymj4XeOJj+UVrRP4Adu4b6jMO+FD64hhGclWiRyCmQIsXLnN+Xd1UEj25UW
         2+0OQfNfn4Da6BCBlelsgOc07G9hJLa+A0nTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729018149; x=1729622949;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NpvuM5Eyhl8BJ2Y8j5Ka7XYXyhujmAW/1IATRx+jU5c=;
        b=C9WXseUYFkTi7lhwn79qWf39ARyQUflPSPaJJiqQoK1l9ohPpDNlepWNJDUJDb3BSd
         IIZVlRZH/Ez/YUQWowBXaWxi2/xuYYKhpoZHEwkhmLXhEfvXjcqKYf6nwtNQl8Le01mi
         Nvrr3rHpl9ejfGj4VcQYybnfzTytuwRz01AX4Bh9GUAQFsxyM6MDLQBX0L588JarZ2NG
         XBb8Ou08pW7TD5csXDj58llzXW18bIc8pffHdZnF2n76u+SCYyet4N3/u9OpRKQWMBO3
         FKyol0Rl9UWieT889lH0v197bzCNR2eB7E6mzxCkXRHXHtn8HXFyatwMXSxVVznc8ksS
         lIZg==
X-Forwarded-Encrypted: i=1; AJvYcCWJhY41pC3A5zQ4LKDKElnatqzrFqlnMiKAZ+UQaSnpyIJLooP3iCQgwTDKQej/aMxATLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLUMT7b4VjdLuKmCJtPyNmTff0rbmsr1im5wbcvibIwgZFDZII
	ASHbqNsLibIjBqD1cMH7lV095qKVfXFwmJOBkLj6LCeFAyJ0gM5lXkF+mndyfqQ=
X-Google-Smtp-Source: AGHT+IHNeu1YHTA0XUZdMJUHgKIPCPagLix0NVME0KnIejJRxKoiN6AkGmh1JPSgiIUWHfbuairT0A==
X-Received: by 2002:a67:e204:0:b0:4a4:6fde:d1c5 with SMTP id ada2fe7eead31-4a46fded721mr10509978137.12.1729018149083;
        Tue, 15 Oct 2024 11:49:09 -0700 (PDT)
Received: from localhost ([91.196.69.99])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b378b1csm9415191cf.75.2024.10.15.11.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 11:49:08 -0700 (PDT)
Message-ID: <670eb924.050a0220.63bb1.4746@mx.google.com>
X-Google-Original-Message-ID: <20241015184906.GB973@JoelBox.>
Date: Tue, 15 Oct 2024 14:49:06 -0400
From: Joel Fernandes <joel@joelfernandes.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: frederic@kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, rostedt@goodmis.org
Subject: Re: [PATCH rcu 0/3] RCU CPU stall-warning changes for v6.13
References: <fb0b7a92-d371-4510-80c4-25a57f2c4f3d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb0b7a92-d371-4510-80c4-25a57f2c4f3d@paulmck-laptop>

On Wed, Oct 09, 2024 at 11:05:02AM -0700, Paul E. McKenney wrote:
> Hello!
> 
> This series contains RCU CPU stall-warning changes for v6.13:
> 
> 1.	Delete unused rcu_gp_might_be_stalled() function.
> 
> 2.	Stop stall warning from dumping stacks if grace period ends.
> 
> 3.	Finer-grained grace-period-end checks in rcu_dump_cpu_stacks().
> 

Other than small nit in 2/3, 

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

I was curious if you're seeing perf or other improvements with the
finer-grained rnp locking.

thanks,

 - Joel


> 						Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
>  b/include/linux/rcutiny.h |    1 -
>  b/include/linux/rcutree.h |    1 -
>  b/kernel/rcu/tree_stall.h |   30 ------------------------------
>  kernel/rcu/tree_stall.h   |   35 ++++++++++++++++++++++-------------
>  4 files changed, 22 insertions(+), 45 deletions(-)
> 
