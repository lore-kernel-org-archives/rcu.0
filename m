Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D0E2C11D1
	for <rcu@vger.kernel.org>; Tue,  4 Nov 2025 13:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762263965; cv=none; b=NFYEPrj1VsNYRKLixPFU0P6SYaXGNzJOOg9w7y4gXcG+QP1WyA9MhsB7tDF0PkorpK/jID6VsKubjcVbM3594/q73ee3bSVZjQJ8hFvebU1jEDnnRHnutdmEHQt+UkWuqYULQJZNlaNtjJPCfPdiboHTZaUT7cJVBd8Y7CgcjIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762263965; c=relaxed/simple;
	bh=6ox1zLtoIs3WHKjGHBqzO0nCO9DbDq7atxZ/hCyqdAU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UW05j5LjxE3WzWzfgGt7fW4nZWYcKPxSdjHXBVKWC8tmOKVHIpZELV61Zj6e2eCFHMlYqYwgrr7e9MVge8+6de5xyrFUFU14Clm96BKkG1y/kMk0yROvXC3KIyIExS8P+qC60Q4k8whrH/0RVLz5JE3xzNo1hdCn+MJ3wW/rMG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZtxIfP8O; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NMHt/x+V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZtxIfP8O";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMHt/x+V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762263962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qBb4JYjcOHMwFtnHDJyHLJFdY3oY5dMhkeGhI5Dhsqo=;
	b=ZtxIfP8OxR2qKPS62sHuMJsx9psPsSPwgIOqjuInzzGFIGdoOUp3a766upCpkD1jNFSTx9
	JxPug4bUSeS81NC0Xp/VZwZN8SK7liM3pgDNdS6DqAkoUuAyNOBkIryw2UzkNLEWmVj4MR
	kChaJtVrLxtdvLYf8U/le0fS0YGJdeU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-yFVasC9NOQeJXSj-1KwEpw-1; Tue, 04 Nov 2025 08:46:01 -0500
X-MC-Unique: yFVasC9NOQeJXSj-1KwEpw-1
X-Mimecast-MFC-AGG-ID: yFVasC9NOQeJXSj-1KwEpw_1762263960
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-429cdb0706aso2420520f8f.0
        for <rcu@vger.kernel.org>; Tue, 04 Nov 2025 05:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762263960; x=1762868760; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qBb4JYjcOHMwFtnHDJyHLJFdY3oY5dMhkeGhI5Dhsqo=;
        b=NMHt/x+VCxgooirjQLCDYJGfq8eGEc+jKFlWyvmdixqj96mNwWuU4Omudek9PMSfdE
         tV4V1t799ZzjfSAgaIwzl4L34z3/dUL5Wb0Z3U9vifro98PyB3buEXmKMgqci9aZzBiK
         PePyAZ6mTZU1uAgenNEPT1bpOp6lYZTXrBvN58KrDF1n6vytzFIHN70Pmj5U4ESIVg8a
         94TRVqT6L4ar/Y/7euFJDAoXZxmJtLdOBdDO6xNAUng+3PjwwBCPLrUsHPWgGSFQDs1e
         WeHAUBAxR9BGWj26DV75bCuu2KGI/PYpGhbRbawb6cl9j8o2lxWtIyniVd9ntxLNVr+R
         AW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762263960; x=1762868760;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qBb4JYjcOHMwFtnHDJyHLJFdY3oY5dMhkeGhI5Dhsqo=;
        b=XkKJoLX8ybZ3sm/JPyIS+LVC8akEn7swMUPKoQJvC24Yjm8uQnGZYA51NZweHj3m+h
         3EvENuwh3kYEkhp8+rBr1S6I6LQEyTKVe9/OKMon61USp35kOnWmys5slaK+rttvooJj
         5R/Tz9dd6wCNDErHFzrjFVPBR4Hpvnc7V1SmaYOoUvcDpjQYDnPYPTb99ZtZkHJMj/wf
         PivyIyg4An4NyzhHFjP30BGd3dFcRZvY2qa5FPz1JsKI2rjSR57gYP7iv1mzLBy4GB9P
         C8G/Zha6hHPE3NZ57R+WcGJZKlooyHTuNSgRpCNqn/SGkL8TAWj2IOOc7Ccsnj1F/ikK
         raYw==
X-Forwarded-Encrypted: i=1; AJvYcCVb886+94McmKCmJ+fy6Yrq/OBMqKC6+2AJc8AayyUzLwnnS9uMVFSZ/ReOgGkwQJBP+FA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgrwD4AN/6OiVeRwTdPGZxfVTyjPeOR4vhYAqsgB0PLwULCHyu
	Zja0AlQkkC6suIOH9GV+vKbcy2PE1D+A6+PKGGPnJ0np83fQihXViiyep8h31ADmBmqryjAXG8W
	29Zk+Gv+Aq2L1o95ewd2K0kCAv/ODzOcot7oIKqoOeB30vMavGzn0uQ==
X-Gm-Gg: ASbGncsmjfDI6YCiVUuLHGiwA85UwhDsVFO8aMD3AabSg46Gv1syL3k22CcruMuB7H5
	n9ielHbA4meUNyAHMr7l6tL5k3316uLYbnO0SrCVGsZrffXfMJI20Cfj1MMvmR21MTveSbWH8EY
	yyBb485WH3qFO66gY/EoX62MyhkePATh39pnRY4J5x57kOn7yaL0yoZaEjHjrfB8vF5Bhs1WjoQ
	muJhV6UK7Tpg/v77cbTVqyPX5zB9db8tJdrDIzCSal6i6HA+bJ7CTvDwIKeZ3MyzIlZoWTuf/Xv
	Fybv8XANnPsujgxGdMs2SiaAUZph2+/o+9uzJD5tsqBzb9eBB0F7sdOk5GWepn7OMiX2l2BHqVb
	28FG3ORpGgfz8tletBVg4am6OiOYXBmgOebg=
X-Received: by 2002:a05:6000:22c9:b0:429:d11b:9ec4 with SMTP id ffacd0b85a97d-429d11ba360mr6284604f8f.41.1762263959573;
        Tue, 04 Nov 2025 05:45:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRnKz3y+r5XoY3ls/nBZPt8sht5PzwdeS+jf9m1q52xASXswgB53muxrTyL7Mvrv/sZwgkKw==
X-Received: by 2002:a05:6000:22c9:b0:429:d11b:9ec4 with SMTP id ffacd0b85a97d-429d11ba360mr6284574f8f.41.1762263959010;
        Tue, 04 Nov 2025 05:45:59 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb ([2a01:e0a:36d:2b80:e937:44f0:a96a:94f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1a8528sm4959089f8f.21.2025.11.04.05.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 05:45:58 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Nicolas Saenz Julienne <nsaenzju@redhat.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Josh
 Poimboeuf <jpoimboe@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Arnd
 Bergmann <arnd@arndb.de>, Frederic Weisbecker <frederic@kernel.org>, "Paul
 E. McKenney" <paulmck@kernel.org>, Jason Baron <jbaron@akamai.com>, Steven
 Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>, Sami
 Tolvanen <samitolvanen@google.com>, "David S. Miller"
 <davem@davemloft.net>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel
 Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>,
 Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mel Gorman
 <mgorman@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Masahiro
 Yamada <masahiroy@kernel.org>, Han Shen <shenhan@google.com>, Rik van Riel
 <riel@surriel.com>, Jann Horn <jannh@google.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Oleg Nesterov <oleg@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Clark Williams <williams@redhat.com>, Yair
 Podemsky <ypodemsk@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 23/29] context-tracking: Introduce work deferral
 infrastructure
In-Reply-To: <dee4dc13-b187-42df-93ce-f738cfab32ea@linux.ibm.com>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <20251010153839.151763-24-vschneid@redhat.com>
 <dee4dc13-b187-42df-93ce-f738cfab32ea@linux.ibm.com>
Date: Tue, 04 Nov 2025 14:45:56 +0100
Message-ID: <xhsmhjz05ud0r.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 03/11/25 14:02, Shrikanth Hegde wrote:
> Hi Valentin.
>
> On 10/10/25 9:08 PM, Valentin Schneider wrote:
>> +++ b/include/linux/context_tracking_work.h
>> @@ -0,0 +1,26 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _LINUX_CONTEXT_TRACKING_WORK_H
>> +#define _LINUX_CONTEXT_TRACKING_WORK_H
>> +
>> +#include <linux/bitops.h>
>> +
>> +enum {
>> +	CT_WORK_n_OFFSET,
>> +	CT_WORK_MAX_OFFSET
>> +};
>> +
>> +enum ct_work {
>> +	CT_WORK_n        = BIT(CT_WORK_n_OFFSET),
>> +	CT_WORK_MAX      = BIT(CT_WORK_MAX_OFFSET)
>> +};
>> +
>> +#include <asm/context_tracking_work.h>
>> +
>
> It fails to compile on powerpc (likey any arch other than x86)
>

Woops, thanks for testing!

> In file included from ./include/linux/context_tracking_state.h:8,
>                   from ./include/linux/hardirq.h:5,
>                   from ./include/linux/interrupt.h:11,
>                   from ./include/linux/kernel_stat.h:8,
>                   from ./include/linux/cgroup.h:27,
>                   from ./include/linux/memcontrol.h:13,
>                   from ./include/linux/swap.h:9,
>                   from ./include/linux/suspend.h:5,
>                   from arch/powerpc/kernel/asm-offsets.c:21:
> ./include/linux/context_tracking_work.h:17:10: fatal error:
> asm/context_tracking_work.h: No such file or directory
>     17 | #include <asm/context_tracking_work.h>
>        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>
> Gating works for compile, but no benefit of the series.
>
> +#ifdef HAVE_CONTEXT_TRACKING_WORK
>   #include <asm/context_tracking_work.h>
> +#endif
>

Huh, looking at this I wonder why I shoved that here. That include belongs
in context_tracking.c itself; I'll fix that.

>
> I have been trying to debug/understand the issue seen with isolcpus= and
> nohz_full=. system is idle, even then it occasionally woken up to do
> some work. So I was interesting if this series can help.

Is there some ongoing thread for this particular issue or is this just
something you're experimenting with?

If you suspect stray IPIs hitting isolated CPUs I'd recommend tracing with
these events enabled:
  ipi_send_cpu
  ipi_send_cpumask

