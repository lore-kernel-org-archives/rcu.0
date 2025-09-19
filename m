Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB962C21DA
	for <rcu@vger.kernel.org>; Fri, 19 Sep 2025 07:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758265567; cv=none; b=LangCgGNmU1qVroyFnvV24ikHjJvjWZF8w6u9FM+FswBHdruV77+CJHphyOwHn6atW+TkwdCufrBQUyn77PRRd/ASismAUMWbgj780kGPJifSGk3LfNWj+lDb7r/ESrXskiyWSFJ+FC00TFz+vn/8w7K8P7IuCOpFTRyZUiDszY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758265567; c=relaxed/simple;
	bh=ItZKaGQl9It/js9gzPNXCsAEXczA+CYbzua9BHh+ovk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFxppYKBVuaqrFjNOM1Z/tfl49iSEwJY31yTktCq56jdEuwpi/pwfViLuPEwbl+z0yvrM3beBTYQZf9kImjl3UvURSI/mK65HtF/4AzAr+nw2e8UuhEyvfJXUAmxBAIdx2rTu116JZ5nYHVAZVLxG93hPd9Iwo8wtttM3AenUEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hCKo2pF/; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hCKo2pF/"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3e9042021faso1259211f8f.3
        for <rcu@vger.kernel.org>; Fri, 19 Sep 2025 00:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758265564; x=1758870364; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Klo+L3KBBL4ssbFZ2YOqJt7BcxJ8M+dYCfYzeUYYBY=;
        b=hCKo2pF/F78auKEP48toZ9iiNufcpa9c36bPf4P6fwtH1zaEBgaQ/RUiLIQk92rhWc
         B1LgQpeOqlgQlCfm8iif2jUa154KDKMvYQlSys5NZtt+K1jFjuxbzMGsfZi6gawxzMjn
         PH1A3hFkQbnoa61/vfXUDV3CSh6jvceVmBuMfBRP49NRPxq7AcTmj8PJJt5FMoY07PFM
         f45k7CojLt6eIQlQbuDN/fIh6vTw8m23VBVFZPh7tGbrilgmVh+/LguX/Dq/QoxcwGQt
         4CRU8KcVWlbcPIAhwDzT0GR2qRk3ORkC5h6ualYsffvKdotgOB88M7c91H+ryPIHp9Um
         Nvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758265564; x=1758870364;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Klo+L3KBBL4ssbFZ2YOqJt7BcxJ8M+dYCfYzeUYYBY=;
        b=DhwPpcV8r03u/c+5MzDyMxnA7nmeiaaeI/OBKAecSx9IeEiEQKTEWeHyhmk8rn2BFD
         8Yy9eEXbYNWyoJCkQfOBaK8NlbMXfQXZ8TAvbyovYHddltdmpTw977Srymb0/0+xxZ0a
         0/M7VnI9IV4XHzumYZqIJDCa1wW6IBU3/GWYQZCiep4+dipIRvS72kc+2UF/2Hl3+0LH
         Q58ge6ZKzRZKg0UQebyWro0Vkmf6Hvz0RqimC1FWw2oiL7vMhsH187z9Xb/Nis/KLxmu
         YlKXDhVU3wyptxTwQPfIUPH3H/4kcF85BdoUVEOujnmTJQAapu7KkTQyyCJHPHKEEOH5
         741g==
X-Forwarded-Encrypted: i=1; AJvYcCWZ3o7hYRFURZi8dgoE1/6mdEqZ2ARNPVtTllYaeB8NyYcWIB0Y6zOuDePVl0oxbyA23Nk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSpp7EZwc9kxgPoX2zrGg31G1hmYX/7ggoqqB2ZxMC+8On+S0x
	XldIAmPVkP0JvgshvVj9HVgfnjzcKCgDq80XkNTyEKw+ipOEbrabSlTtcLgeXkSfbA==
X-Gm-Gg: ASbGnct+Kc8LTET6fvxZikw8TajpT66w4Zqkum1+LP0YyY26yA3vK0b0xMb8Udsv9GO
	RSTAg91j9JIqXyRZHl4AjO9SE9HMe812755N1miihUDTs+QL9F+TwksV+yGq0iXLN1DJNApfbXT
	vkzwNYizvttIUogCUljecE1D7iW+H8hLm8sG2N+GDcZRVSBSkTvOV+P0yIlNSWEbNNe9qUzONbq
	tYgDc3+haqpXAEGsBrLGH+HndOAlqIQLSLdb5GNFMjNfnkI/wt+9em2CvM7mo9Ekg3+oHY2gjjx
	YnRQ5BXZvlR7xCjwgIwru7UHV9Msgz3xPAch/iuXRNFhhtJN+i8JhHDVNZZe5s6aM3NcGO5rsqP
	bQTzWib6YzGCp7hLP8NJ61llCWQJ0a87W2vVL6D9Ktjl/dPWdWYwG6pT3604=
X-Google-Smtp-Source: AGHT+IHPi1pgPaxjy0qFYAQQyA+9c6RpQAFZf3vA/UzVRkHTrs+JR5MqjC9zARfGu5kWXbLyHGkoeg==
X-Received: by 2002:a05:6000:2c0b:b0:3ea:6680:8fcd with SMTP id ffacd0b85a97d-3ee7c925245mr1570227f8f.13.1758265563176;
        Fri, 19 Sep 2025 00:06:03 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:2834:9:1f7a:8520:7568:dac6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbf1d35sm7200088f8f.55.2025.09.19.00.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 00:06:02 -0700 (PDT)
Date: Fri, 19 Sep 2025 09:05:54 +0200
From: Marco Elver <elver@google.com>
To: syzbot ci <syzbot+ciac51bb7578ba7c59@syzkaller.appspotmail.com>
Cc: arnd@arndb.de, boqun.feng@gmail.com, bvanassche@acm.org, corbet@lwn.net,
	davem@davemloft.net, dvyukov@google.com, edumazet@google.com,
	frederic@kernel.org, glider@google.com, gregkh@linuxfoundation.org,
	hch@lst.de, herbert@gondor.apana.org.au, irogers@google.com,
	jannh@google.com, joelagnelf@nvidia.com, josh@joshtriplett.org,
	justinstitt@google.com, kasan-dev@googlegroups.com, kees@kernel.org,
	linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-security-module@vger.kernel.org,
	linux-sparse@vger.kernel.org, llvm@lists.linux.dev,
	longman@redhat.com, luc.vanoostenryck@gmail.com,
	lukas.bulwahn@gmail.com, mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com, mingo@kernel.org, mingo@redhat.com,
	morbo@google.com, nathan@kernel.org, neeraj.upadhyay@kernel.org,
	nick.desaulniers@gmail.com, ojeda@kernel.org, paulmck@kernel.org,
	penguin-kernel@i-love.sakura.ne.jp, peterz@infradead.org,
	rcu@vger.kernel.org, rostedt@goodmis.org, takedakn@nttdata.co.jp,
	tglx@linutronix.de, tgraf@suug.ch, urezki@gmail.com,
	will@kernel.org, syzbot@lists.linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot ci] Re: Compiler-Based Capability- and Locking-Analysis
Message-ID: <aM0A0p4-3lwLeAWF@elver.google.com>
References: <20250918140451.1289454-1-elver@google.com>
 <68cc6067.a00a0220.37dadf.0003.GAE@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68cc6067.a00a0220.37dadf.0003.GAE@google.com>
User-Agent: Mutt/2.2.13 (2024-03-09)

On Thu, Sep 18, 2025 at 12:41PM -0700, syzbot ci wrote:
> syzbot ci has tested the following series
> 
> [v3] Compiler-Based Capability- and Locking-Analysis
[...]
> and found the following issue:
> general protection fault in validate_page_before_insert
> 
> Full report is available here:
> https://ci.syzbot.org/series/81182522-74c0-4494-bcf8-976133df7dc7
> 
> ***
> 
> general protection fault in validate_page_before_insert

Thanks, syzbot ci!

I messed up the type when moving kcov->area access inside the critical
section. This is the fix:


    fixup! kcov: Enable capability analysis

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 1897c8ca6209..e81e3c0d01c6 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -497,7 +497,7 @@ static int kcov_mmap(struct file *filep, struct vm_area_struct *vma)
 	unsigned long size, off;
 	struct page *page;
 	unsigned long flags;
-	unsigned long *area;
+	void *area;
 
 	spin_lock_irqsave(&kcov->lock, flags);
 	size = kcov->size * sizeof(unsigned long);
