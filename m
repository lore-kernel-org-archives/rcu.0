Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C375B7442E
	for <rcu@vger.kernel.org>; Mon, 15 Apr 2024 13:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187930; cv=none; b=bB8ZdkVHSFqQNa1x4V8PRJXLG6+WKXmYXrlg69fWRVjndd3NHvDy5DD5lDmMDKMrnrFkY3ElNqEQgwRPqDR4lPWXLeuGdsHxESp/Hol4ehcl/7DMHfyvMLeF9A7BMA9y79iAje+0XS1T541y5VErxDCHEEUUrCuOA9/YN5Roal4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187930; c=relaxed/simple;
	bh=kzx1DBnLKpi08wmIRgOdyPjiQsqA0gVKstuQ6y/nCbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGUt97+0ZchdBOcNr9FQkPXplREbCAxCG6k9yMZkrZvn9+fLSYHjt3i9yhzskjIp9fsASSvcgWcUwSyrg8fkAPb5odp/DeEwru8APq9BMfvs82HkMKWwDOoxJgHrzSuYMmcmkKn750woE2cW0GcLrb7aHZX5E/4vZ5WRCgmWz4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KXgGsaHa; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KXgGsaHa"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41881bce4b5so1152755e9.2
        for <rcu@vger.kernel.org>; Mon, 15 Apr 2024 06:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1713187926; x=1713792726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ru8k+KECT8Y+LJdvEDygQBg/FVMZmjLsBdJB8usbclc=;
        b=KXgGsaHa6ht+yBD/kDS1ntfiMnkRqXyAk4EIffVEfvA5FebIjigPo3MtOSjIIqHOCV
         mkoOJgGNJ+QKQXiewdeTGtsGWmIseRHjEJvLSV8YYXxmrZ5p/Ihf98P6QcLhPmnxIz+x
         mmvnAWv2V2FOIu7do6S4esg7K3786QoxzGwsQHoZ+xUSSNmwM1gCrgNxZfhJ1eu4MSVJ
         xa/jsyC38C3ikYPWUjNMlhUGtYjzwnJN1yYYB4ZlzHD1qHuRHenUb8zXMuXvYnqp/A0m
         LSFB/KPmW0Sr+pqQ3Q1YeJ7eQfLLxgQaR4jjVmVoPV+eThqfRNVEJXc/Kf0Q/OP24OVk
         7PnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713187926; x=1713792726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ru8k+KECT8Y+LJdvEDygQBg/FVMZmjLsBdJB8usbclc=;
        b=iO382BNIYfZiDtUYy479WFPdHaDW1dE1IWgvzCYe0DWduc0X8NG1JBGVbkT/fx2FsF
         oEQIey7GSl4u+s58xqgBf2r6nXARbltMMxi1QAkPuijp0mlyCgnOfwXySB7gLg1q4f9P
         H7N8tnIEfnpv9+fQG+lNb9rrp0L2d6d0ToJcBECv++oIzRmguNrwpcyYCoenRJq9f2em
         iJQP/pEmZRARsDXlBq4tyUK6menuKIqfmPsIZg/aS4bAPlS1qT0afrMfO/Ki6Wdvsb1g
         KqbX45TXhWrl+EKj8ZMj76i1MIGag4ABXAdQlUBqC42lBN8R/jyaLXfwu/Qu+BwdEBnR
         r5vg==
X-Forwarded-Encrypted: i=1; AJvYcCXFDr0n9K0FGQZcMttT/x5i3/KJ3X/9IyM1emkAkCnDgQh15ikuYIeV0Yk+9xVShaUSEwqwegkQ/9RotajsPJJMOycE
X-Gm-Message-State: AOJu0YwqCQ1mJhWU7pTxVum0U5KxXdxI9jqLm7fCqm7D7d8PM1qjlPio
	lcC6PJMf3S6vzobII4Ziug4NL478UXcYjPWJHtSQugl0jtyZg8xs/c0AhnvJxvGfYDxzAaIzsbr
	P
X-Google-Smtp-Source: AGHT+IFwLZXYlG13hPnaGZf4kfDx4jn2IX9lcb0QuIHjmhGRVa6Sb/7N/TOv9F3RcRfCXz1ovTWYfw==
X-Received: by 2002:a05:600c:3b17:b0:415:6e23:28b5 with SMTP id m23-20020a05600c3b1700b004156e2328b5mr7917096wms.32.1713187926106;
        Mon, 15 Apr 2024 06:32:06 -0700 (PDT)
Received: from localhost.localdomain ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c35c400b0041638a085d3sm19634651wmq.15.2024.04.15.06.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 06:32:05 -0700 (PDT)
Date: Mon, 15 Apr 2024 15:32:04 +0200
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
Subject: Re: [PATCH printk v4 26/27] rcu: Mark emergency section in rcu stalls
Message-ID: <Zh0sVN-bwWwavljV@localhost.localdomain>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
 <20240402221129.2613843-27-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402221129.2613843-27-john.ogness@linutronix.de>

On Wed 2024-04-03 00:17:28, John Ogness wrote:
> Mark emergency sections wherever multiple lines of
> rcu stall information are generated. In an emergency
> section the CPU will not perform console output for the
> printk() calls. Instead, a flushing of the console
> output is triggered when exiting the emergency section.
> This allows the full message block to be stored as
> quickly as possible in the ringbuffer.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Seems to be on the right location:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
