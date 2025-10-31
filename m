Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B40534D397
	for <rcu@vger.kernel.org>; Fri, 31 Oct 2025 09:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761904545; cv=none; b=dBpRYaijh8g0OrG9m5SLfC37ZdW54wsVfFMnblrzbmkbVcACKzi3hiJHW9hRdbODHZ5MRM5FDUULajn/1ahRoZoSjfMVxTth1BTFTou1orfEy1NlTzsrpqo9hfFxIlNtennqhGyuk57oz4GvffVwrZmD6sg3DqXxyj+DhbBpVqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761904545; c=relaxed/simple;
	bh=kTCg+N3NYwBLqF+pIITZOoHrF01dYEOCOu0+H1nRDT0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I6iWKmUWaGXqZBRb1VLw1b1tlLizJsnt3HHhxBGg0GvpaqYU6PxNn0dMrvyf2wu+44DzrF7b/W1HPt7jRniVRkQC4IAFhgjHplTQdqRvUXrYkn9InIOhnI5aB2ZWPrXHH2j3ZeIiX3rQH7mCqy1P7PssJsmJOVf2PmBGeSLjho8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QDS6ufCW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QDS6ufCW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761904542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kTCg+N3NYwBLqF+pIITZOoHrF01dYEOCOu0+H1nRDT0=;
	b=QDS6ufCWZz1lF5hV2Y3i6QUMRhHJ3h3sQmCe58iBzunyP0lpcKoNbI7hfnRw6ZH5ermo8b
	aFE1Hi2m2p7UXvYF+Rt6kU1jSdHce/RhKGA1jcMfsAHxa6loKvfnWpDdYH35BoVa0LacRQ
	McuFipCNuI/Ry+enNMx2oUNw+oClcC4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-hG8N2fbbPNabIFiCPGfRkw-1; Fri, 31 Oct 2025 05:55:40 -0400
X-MC-Unique: hG8N2fbbPNabIFiCPGfRkw-1
X-Mimecast-MFC-AGG-ID: hG8N2fbbPNabIFiCPGfRkw_1761904540
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-429a7f1ed1bso933027f8f.1
        for <rcu@vger.kernel.org>; Fri, 31 Oct 2025 02:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761904539; x=1762509339;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kTCg+N3NYwBLqF+pIITZOoHrF01dYEOCOu0+H1nRDT0=;
        b=I/Xeqv9+u4G0HaPhHr5RWB7pJElaSuLlQ6bTlvTGJJYFxPdShCQ0QeW8YZOOV4F4Km
         vmpSusnEpv/neF+lOEazOQl7F6aOqqFepVuLDGIg7rLBAZtER2o9HqlVkq4GWN5m2xar
         TNzWu1YF2csdos2VF2JdFvZnekMwxh3b09zBF82fHt3/WZ81+RdWNUeGeUaxYFOX7CQc
         kMtiTMAVksOA5OSLahtJz+2ha1jax2qE8nylny1Whz4+qn5sNeGcQ0/8djbYOqLpf1D1
         689tGQZbQadDq5/10LdNMKkNXKzLyIEhcD+w3iLkG4mAvKHPcNa5UeddamAtjOXjG4tY
         gpvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmZrmK2TzxYmFEf/QZicxEGOL4Hi10RiCuZ+s7a70ZXtkn62g5fsDMKJE+K4cuEfesgyg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5an3vmbQxU+46JMkHA20ZXNQyjOmIN95R0CcO8rRdYH9AWrAo
	ZVQWpc3J3Eqnhspm/3wzTRhF2/25DJwjmeCz04szfJrlteaKn1qsEUp6PTN+N4rIHJ8W7cDm9cx
	6uj14tfLBViJpzxMphjZ6jmHvNnPxVJR115eR/ItQX1btmEos8LhbbA==
X-Gm-Gg: ASbGnctQD0FaVGE1bnWLU9agqRGjSo0IuH5h0A8p0QCDRGclqfdxNmuLjbONbiHglmt
	8DSEYbWGLAmWMlzt/KLKYYb+LzbJb1EOGtYDGWq0a3Xc80wfyfTdcP8SJ0MQWwZMtTYnKzVMhgq
	x+14b8g/OJ0Q6PBfWDg5hmVV58XJHNiC0kvcLnF+DKeKGADYNQm1iin1QXgQQtpDc/QJUZvRF/S
	cjFv4zW6bmJZWF6kJ8RawL+fkFQpy5cYRO4opFw+wYNkt7z4PyU2qDrq88PL40aZK60eu2upl5K
	SLmf3sOtNtjAjgw+csVT+cRLY2NoeMt9eyCzgONB1j7SYzAuUHZTOS9vaXYwTzzQ7Q6TG8pABTl
	QObH67E5qBvfa2i0RK1HzRXgmEF4CS7nnhJYOVU7yw9QrZUug/MMje2b8VWGK
X-Received: by 2002:a05:6000:310f:b0:40f:5eb7:f24a with SMTP id ffacd0b85a97d-429bd68869amr2437813f8f.12.1761904539497;
        Fri, 31 Oct 2025 02:55:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbUxApmJAOYlrcJigfNqaTRZ7Pz52J94NiUAhMgZ/Qwj+7BmCVMNCnPqwOLJ11D9kpjdgFWQ==
X-Received: by 2002:a05:6000:310f:b0:40f:5eb7:f24a with SMTP id ffacd0b85a97d-429bd68869amr2437793f8f.12.1761904539055;
        Fri, 31 Oct 2025 02:55:39 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c1406a45sm2624895f8f.47.2025.10.31.02.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 02:55:38 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "Paul E. McKenney"
 <paulmck@kernel.org>, Jason Baron <jbaron@akamai.com>, Steven Rostedt
 <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, "David S. Miller" <davem@davemloft.net>, Neeraj
 Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes
 <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, Boqun Feng
 <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Mel Gorman <mgorman@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Han Shen <shenhan@google.com>, Rik van Riel
 <riel@surriel.com>, Jann Horn <jannh@google.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Oleg Nesterov <oleg@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Clark Williams <williams@redhat.com>, Yair
 Podemsky <ypodemsk@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [RFC PATCH v6 27/29] x86/mm/pti: Implement a TLB flush
 immediately after a switch to kernel CR3
In-Reply-To: <aQIpXyX-z8ltB1i5@localhost.localdomain>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <20251010153839.151763-28-vschneid@redhat.com>
 <aQDoVAs5UZwQo-ds@localhost.localdomain>
 <xhsmh3472qah4.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <aQHtBudA4aw4a3gT@localhost.localdomain>
 <xhsmhwm4dpzh4.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <aQIpXyX-z8ltB1i5@localhost.localdomain>
Date: Fri, 31 Oct 2025 10:55:36 +0100
Message-ID: <xhsmhtszfpf8n.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29/10/25 15:49, Frederic Weisbecker wrote:
> Le Wed, Oct 29, 2025 at 03:13:59PM +0100, Valentin Schneider a =C3=A9crit=
 :
>> Given we have ALTERNATIVE's in there I assume something like a
>> boot-time-driven static key could do, but I haven't found out yet if and
>> how that can be shoved in an ASM file.
>
> Right, I thought I had seen static keys in ASM already but I can't find it
> anymore. arch/x86/include/asm/jump_label.h is full of reusable magic
> though.
>

I got something ugly that /seems/ to work, now to spend twice the time to
clean it up :-)

> Thanks.
>
> --
> Frederic Weisbecker
> SUSE Labs

