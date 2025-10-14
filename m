Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B2A302759
	for <rcu@vger.kernel.org>; Tue, 14 Oct 2025 11:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760440815; cv=none; b=fKIYS/FrdPSCyU+gKCFnmg31xrgIZr6Tq2xxJBPWxXO0XF2CvAZDqZrXI7u2EFm0k3+df1k6lC0sUUkhEsT7FT0ujouB0IowD80swkL9opkdiYC5ezgJhz1n27TEsdmasbYECzfYLqZ/ogWA0i5rILk7LSvkwo4iy3OC8CgQYM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760440815; c=relaxed/simple;
	bh=yX5dyBuNEa2OXACHjn8fnbGsDn2mXnkquyRkiu3aCD8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TBNsfGlOGUqeFCl9ifZHmEfD7+vzxiCYe358edEosUYXjj5Y4tvoiB3U0y5a34QN0Go16iQtth5LywfdNp+bu8A5aawPUco0p8m5EMusZ+LXSX+Gf8PbHn6kYzFmw8KOsr359A2GBjAtPerbPF/p6b1dQ2FTtc9lBaYuM+OHKxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JLtaCswH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JLtaCswH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760440811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Imuve1iPcSxB4uVU/yFQsIzQ6zKzpq/61jJo3KbkM2Y=;
	b=JLtaCswHk/AW7ow1AFK8jpTTCTDmRdtWf4uRPQp+yJ+Cxgn9K2tK3EJ3EGx3Yxyuv5VOvW
	8MeIBKkAvdUbrmjYWsS33vur/yPGKfntdccd+N0/n4Jaz5s7kZS2eR6PLLvt3t0j3RlMxC
	JICyHnc66knRbsr4oO8lRpKs7rDX7So=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-CcUy5S1AMpGXuHsZZK95lQ-1; Tue, 14 Oct 2025 07:20:10 -0400
X-MC-Unique: CcUy5S1AMpGXuHsZZK95lQ-1
X-Mimecast-MFC-AGG-ID: CcUy5S1AMpGXuHsZZK95lQ_1760440808
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e47d14dceso29915045e9.2
        for <rcu@vger.kernel.org>; Tue, 14 Oct 2025 04:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760440808; x=1761045608;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Imuve1iPcSxB4uVU/yFQsIzQ6zKzpq/61jJo3KbkM2Y=;
        b=E/j7PgV8Ap7jlACEaDKXSYk62WnzC6vbjcwLqdT076Z+7fkB0dKxg/zPNb05X0ct4A
         q3WKxtR6FocZ7DBV3HSO3ftOXbyxDvxg5GR4Des83bRJ0iNNyhKGVw2s0QXrdjn/D8Y3
         MEvNn121sDaTinV24XM+eQWweegIh+h6nzznB9WdaH+vnMn0ml2xVrXvbiIOWX6z8rb8
         JlTNNZB6Q//WJ0Qi/BtsPzpORF9/fBlS9CyXUUkEuKzmQ5Xo9TzPfd2KPdQVa7qcbQXE
         wgVIIafZslCIKmg8FbO4FRBAUek1RMoP9nn4porH+hemBKgaZCAVQgvnL0WBZfZQ6mki
         yWhg==
X-Forwarded-Encrypted: i=1; AJvYcCWWjp4u8OPZwSkuV7viCUotG1MthmGlII8suxzXHKQ+kOJC/Y9nStld6MwS3EGCuht0GOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdRIx5TNIMG/t6GYA7OW5oH3EweNz38d6LcwymwDY+lI6lFkXl
	QowCk6d/owwcYTbeRiQIEda/gaKTmEVQdH90Qzje/5rslImMyWSOlbTOKX5Hjn73mp5xxAm3u2l
	Fls3Gwdoqa6RXb2N+l01hqLTsZMS6sAN/bR/cgr8KxNol+oJ7Jm4Kuw==
X-Gm-Gg: ASbGnctWr6omaRzzh9aQ6cDwgLjHmW65RBcOtnxWXk7OatPgn3Jglvssiet7MqG+GVG
	Nqvuuo3bAZjznwFshSxGUmjf5mSzfMxhgTjLnRzRfglZ9HiANsUoFQVhdmiGAH0kFkI4Tq+d9fN
	7yL9SDQwmrC3W6+unD+6SmQpdv8HdkLPvdw/zJuFXFBE+QsqdDruSUWwNzAT6zQnfypnKDEhZiQ
	eUgo2m1GMdD2w4N5qGrUBgs6xoWFD/+rkyJVfKYs2BxjSYMmaJYI6ZC/OhLCV05vGPlQZftcpUv
	N7VvZrmuE36m24cCMNPl95AjY50NXGim2pyZMNN76QZgL0yCo2z3FgJ6MyrVclIqlUK9If4k7T6
	quuhGBeK1Z/HEyc8OKvRzfyqpCw==
X-Received: by 2002:a05:600c:37c9:b0:46e:477a:f3dd with SMTP id 5b1f17b1804b1-46fa9b1b18emr175576725e9.36.1760440808240;
        Tue, 14 Oct 2025 04:20:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPNHhJVacE21hOu+c1s40cKBm99NOdKTbqBsl6lzaW/V++U98Y1cwp6CoRkBLGlZny7BSyXQ==
X-Received: by 2002:a05:600c:37c9:b0:46e:477a:f3dd with SMTP id 5b1f17b1804b1-46fa9b1b18emr175576075e9.36.1760440807708;
        Tue, 14 Oct 2025 04:20:07 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb492e6ddsm265506695e9.0.2025.10.14.04.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:20:07 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Frederic Weisbecker
 <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Jason
 Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, Ard
 Biesheuvel <ardb@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 "David S. Miller" <davem@davemloft.net>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mel Gorman <mgorman@suse.de>, Andrew
 Morton <akpm@linux-foundation.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Han Shen <shenhan@google.com>, Rik van Riel
 <riel@surriel.com>, Jann Horn <jannh@google.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Oleg Nesterov <oleg@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Clark Williams <williams@redhat.com>, Yair
 Podemsky <ypodemsk@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [PATCH v6 16/29] KVM: VMX: Mark __kvm_is_using_evmcs static key
 as __ro_after_init
In-Reply-To: <aO2TKOY5JV9OoRUg@google.com>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <20251010153839.151763-17-vschneid@redhat.com>
 <aO2TKOY5JV9OoRUg@google.com>
Date: Tue, 14 Oct 2025 13:20:05 +0200
Message-ID: <xhsmhtt01pw62.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 13/10/25 17:02, Sean Christopherson wrote:
> On Fri, Oct 10, 2025, Valentin Schneider wrote:
>> The static key is only ever enabled in
>>
>>   __init hv_init_evmcs()
>>
>> so mark it appropriately as __ro_after_init.
>>
>> Reported-by: Sean Christopherson <seanjc@google.com>
>> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>> ---
>
> Acked-by: Sean Christopherson <seanjc@google.com>
>
> Holler if you want me to grab this for 6.19.  I assume the plan is to try and
> take the whole series through tip?

Thanks! At the very least getting all the __ro_after_init patches in would
be good since they're standalone, I'll wait a bit to see how this goes :)

