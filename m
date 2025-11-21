Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26D82DE6FE
	for <rcu@vger.kernel.org>; Fri, 21 Nov 2025 17:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763746638; cv=none; b=lGCrCK915w0EnwZqx1D9DQGEvy0U/+GqCbDQR/DTf2vwcgpu3LNdjaveBabut6vbs4PJBE+PVoIMlshpewm8zbXh32BckVr39VlE+2Q/srDUIlMUgXGHrDyJmYjrVRPxV2lMMMNKnypo9vosNHDFoxEyLpf7h1rNwBxLoRmHoqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763746638; c=relaxed/simple;
	bh=R6+it4z+8J3tQq6khArTa00xBA3LI+Aiux4czwnNIBo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B6RJ0pZpabxT+cPh79qR83E2xTOaxIFR5ADrym1+ewAWmz6fW0uH2RHxVDo8CQyYNK5XJAIAdEqFFSvL9/GEpj9bCa3D40RVSvRS2eI+Yv8IY87J9JX5xw6UZoC8lgs0+xqfKO0Dcc1iwi7bLqEw6z2mjh/mHcFSS2tauOtCh90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OJRkF1yN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=U5vLJe8L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJRkF1yN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="U5vLJe8L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763746634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V3OE0zpMaGFe7FLO1SjE8KbYNBSyHZmUa+LcldBnwuQ=;
	b=OJRkF1yNZxr96JULB17P9/EUvhx1Ox0XH45RgxSDoXu12qcbb2Fsx2+fxxBe6klYybU212
	b+CpIW1WpaAYjcedmq2yVuzD9sRdjiy+lOZskX/WCBt0hAdREv4ja0gbYzdaO7ZAFZMslh
	wmXNjDsfgRVSWVwv2Koi4mQtjF9zlTE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-gIjwynnKPdSl-al7-KeW-A-1; Fri, 21 Nov 2025 12:37:13 -0500
X-MC-Unique: gIjwynnKPdSl-al7-KeW-A-1
X-Mimecast-MFC-AGG-ID: gIjwynnKPdSl-al7-KeW-A_1763746632
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42b3086a055so1993214f8f.3
        for <rcu@vger.kernel.org>; Fri, 21 Nov 2025 09:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763746632; x=1764351432; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=V3OE0zpMaGFe7FLO1SjE8KbYNBSyHZmUa+LcldBnwuQ=;
        b=U5vLJe8L0a86P8h3MUZfCtbqbvtoJav9VqBJbzGwf61gnaIKl/s1ka74ifirX2UroI
         kJ86MkvCZ8sKjWHApHl63yFVSHGPDwB5hNcY4FjCYgKmcvdqrHdIwaxoDVnW21FkmTXB
         zxQOb3rXyaOSMALSYhMxCu+bHfC2taAVRkEfirNyEcCB2HxWBVvXmaYGMmr8HLrSJFf6
         8lE5rImjmJ6jk34LfcWBkrwJTcNuDEqGuus5AgqHiT+2piOy0SPRNOq+dg+zVd435FMY
         zQgGVYaTmaqBtIzcUP6Fg2UbLesoplRxwogEJgvVkb9Dtv6kp6yHwcDsNar4mPKUmwHz
         n9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763746632; x=1764351432;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V3OE0zpMaGFe7FLO1SjE8KbYNBSyHZmUa+LcldBnwuQ=;
        b=ntNTrhJo7Lpufx4SLW5XFqoQ/TUV7x86lamKfY/d/165B3qXo8ClByf6pe/nzpSyod
         oL9/2kzxKjJ3KqnaMw6N9lvRJdn9OuqgqS4CGBjZ6rjuhdU6wA3eAZ8WazODLvevXNZ/
         dmB6+VnVv3cTuHH4kLDrgNb+GItUp5QyktCnr2XglQ5S3UUMndPeyJnOgzjA9sOBQ+5w
         nKPVpZNmyIcNqMqHGTCOiS6jCduinVgVG73gO/ruuJLULnJ7knefzuKys6u5iWFWNpKL
         Ah3gMaFaxHcH7EstvAk3FaE/9bmGN46ncBkSmYnHs5RDMbK0tv067QH3X/n3+l3Kfpju
         k1kg==
X-Forwarded-Encrypted: i=1; AJvYcCUjfmgseMMegOPtcJaGDj2YsAE/iFntV7L96IkSS6UsdCVfEx589zAblSgMFIpKWObbROY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwZMBsHH9XuFZUsEi9fi5YPtzEki1aOv8LAVCX/BT1Cim9h4Nf
	I37uK2StziAMaqZA6co3ZZwA6sBH1bM5rIiswyk4+hDjI2m2NkbTJ7ICjyKbJGSYAosMPTnb3a/
	EF0glg8alFYcAkwFZWr1yJod/vuY9tXWZCa2KbrvKz2K03uDNVUWHwA==
X-Gm-Gg: ASbGncsUiWlT05uUTXE2AX6MUJy8Ca0UcBQuTY/a62xI0jMXNUQWujDycgFyz8sxM5T
	igsB3CwtxgtfWGLG1r/a/uR4nMkAWWM8uNyOB6tCZJ8aWpdy2B4ZCc2H+/OZuscF89p+IwCR6dD
	inxW3UHhyjI02Ia0wWI/vSWQBwa/4Dkb0TItkGcnUJQE4Th0GrGMd2AQPkyaJqOPULqLHmCoLIk
	h4Jpno4AeidNh4/kdOzskPgiOKdKglhz1fMOYusa44fy8s9eZEfvHbx+viogQvro5f7DwX3bNH9
	2EUKLQeLCXajrH4Autj0RlF6taje0Ck4YPVqZ0p9Fbkz5q5jBq8YMCKNswpDsfhZKr55rH5NdhR
	imi4qn6iZkze/j/TEOSwDd4ISTm8/UxZghCUMU8sNGj0vQbtXabkO4uijwtyBcmbXLMQF6Q8=
X-Received: by 2002:a05:6000:2282:b0:42b:3ab7:b8b9 with SMTP id ffacd0b85a97d-42cc1cbd0dcmr3334278f8f.20.1763746631980;
        Fri, 21 Nov 2025 09:37:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwrptJrvQrMlATO+zOU3GD53XUKYoEIwVBRtwZMVM9uxcxDwDk+rU+CpbkpyNs1Ksl4qe7Bg==
X-Received: by 2002:a05:6000:2282:b0:42b:3ab7:b8b9 with SMTP id ffacd0b85a97d-42cc1cbd0dcmr3334227f8f.20.1763746631366;
        Fri, 21 Nov 2025 09:37:11 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cc231dc6esm4094867f8f.7.2025.11.21.09.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 09:37:10 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, rcu@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter
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
 Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: Re: [RFC PATCH v7 30/31] x86/mm, mm/vmalloc: Defer kernel TLB flush
 IPIs under CONFIG_COALESCE_TLBI=y
In-Reply-To: <bad9eaaa-561a-498a-90d1-fe3a3ab8ba37@intel.com>
References: <20251114150133.1056710-1-vschneid@redhat.com>
 <20251114151428.1064524-10-vschneid@redhat.com>
 <bad9eaaa-561a-498a-90d1-fe3a3ab8ba37@intel.com>
Date: Fri, 21 Nov 2025 18:37:09 +0100
Message-ID: <xhsmh5xb3thh6.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 19/11/25 10:31, Dave Hansen wrote:
> On 11/14/25 07:14, Valentin Schneider wrote:
>> +static bool flush_tlb_kernel_cond(int cpu, void *info)
>> +{
>> +	return housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE) ||
>> +	       per_cpu(kernel_cr3_loaded, cpu);
>> +}
>
> Is it OK that 'kernel_cr3_loaded' can be be stale? Since it's not part
> of the instruction that actually sets CR3, there's a window between when
> 'kernel_cr3_loaded' is set (or cleared) and CR3 is actually written.
>
> Is that OK?
>
> It seems like it could lead to both unnecessary IPIs being sent and for
> IPIs to be missed.
>

So the pattern is

  SWITCH_TO_KERNEL_CR3
  FLUSH
  KERNEL_CR3_LOADED := 1

  KERNEL_CR3_LOADED := 0
  SWITCH_TO_USER_CR3


The 0 -> 1 transition has a window between the unconditional flush and the
write to 1 where a remote flush IPI may be omitted. Given that the write is
immediately following the unconditional flush, that would really be just
two flushes racing with each other, but I could punt the kernel_cr3_loaded
write above the unconditional flush.

The 1 -> 0 transition is less problematic, worst case a remote flush races
with the CPU returning to userspace and it'll get interrupted back to
kernelspace.

