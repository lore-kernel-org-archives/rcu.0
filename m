Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3FA4C84
	for <rcu@vger.kernel.org>; Wed, 24 Jul 2024 07:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721805808; cv=none; b=LOUYOE3+7E9GlMpJ1Z25MvV92nv1iJDnAzAh7PyM5blt+a8zJPCEJcD2PB+ARKOGlM8r55XMe5hc7M7mxSrIkytk9gRCnUzLrmUGZVADSIZ1MwLxpWCXm5VzAwEvornmb6C5guiyXvcFy06BSwBWDlixb2zyzgbujISZESXM8yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721805808; c=relaxed/simple;
	bh=i+3Dw5TJO9f+FsTkSAq+Gt5Tp0i9wBPk/hzAx7812HA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YijA+NR+XzoG+2OSfGRauIKpI7ziFmEp2qXA4oJJNeu1TA9UY/FLoWHwCz7Fo0AWckbKetsPmHNdQ76m7rPUDCWKVEsUpvX29/NIxFeB8tkQ/Vz9SEdkj7W92zeQGLgDTMCXux72cMTgEeZnvD0qrkZgM+vXfl0PsXUOT413jM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VmyvbAsG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VmyvbAsG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721805803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i+3Dw5TJO9f+FsTkSAq+Gt5Tp0i9wBPk/hzAx7812HA=;
	b=VmyvbAsGU9dtzATXJIqwgw1BuGgSdriWbPvICdybf8ulXpQ7Bfk9MqGkp+BIioXMH7XWPi
	6aycuOvSD1x2BvrMbVC26RpX3DGf2Sjo7vksX2IaZTWuAZlFsnhqgM59mQzcG6LrwYk0sq
	vVsi/IrhUoI0gwCRCauKyMxC85dMkk0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-JMfpP_5JPVi_QdLj-h2IUg-1; Wed, 24 Jul 2024 03:20:47 -0400
X-MC-Unique: JMfpP_5JPVi_QdLj-h2IUg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-44f4e1569fcso83804491cf.2
        for <rcu@vger.kernel.org>; Wed, 24 Jul 2024 00:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721805647; x=1722410447;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i+3Dw5TJO9f+FsTkSAq+Gt5Tp0i9wBPk/hzAx7812HA=;
        b=aivuuIUTHCzjNueNTnb/DOI5x8CZsBIelyqqGGgZIMPyIiE8Sf+FkA4rGsYjx1R7IY
         Ws4AQ9LpKlRBaZjmZvJMBnzJ+u6L8ltmwcxTeu4ooZNmP32RdMK3zSVpfiVM1Dl0DLD7
         XRhKXPDvGoJad8MEoPMu+pcm5axT6sZlEoEgb1pj8N7grigAz1egdGBtCzMldLuQZtOv
         BeXgiUv7u0fd4iy17V5GBCkm1q1J6kYXGDJijfwchJ9Q2gkVVLcUavndsvIk4L+lmL0H
         4NpSRuP1XOC2m3YS1ZIjK1K6VurOIngew47y8XE90YCFk0UjFidDVrR72/T50ShNRxMR
         aBMA==
X-Forwarded-Encrypted: i=1; AJvYcCXulx24a/G9a1DPJgbWH/qinPF3zsOjB1YVF6nNlkcc4kGKTgajCjxA5JHkzyx3wxR4v8Q2kUxcBRXaLww+Q4jSgU3O
X-Gm-Message-State: AOJu0YzW/BqDEjZwz3sF5puh9T6JVWR5tdqtLW0WGCnGfA5xn61JSvDY
	pOuw98Omt4IhV1E7emBoysKa3lfnEEOcwHFWOUhAL5uDhWBYrU+Y2IAMlLPcxbWCcniwZClz0+6
	3cEQpeJ5cFwjNFlAoCZioz1SiMdQHnYtKnwJs0j/AH+cfZXYHTQ==
X-Received: by 2002:ac8:5fd2:0:b0:447:e3a5:27a4 with SMTP id d75a77b69052e-44fd690c70bmr13334971cf.52.1721805646801;
        Wed, 24 Jul 2024 00:20:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3hwHQDyxNrmuz8DJLgtMTsUP1m4eqMytdEyB3bMxyRU0LAKgTsDlpFKTWSObfLA3s1kZhxA==
X-Received: by 2002:ac8:5fd2:0:b0:447:e3a5:27a4 with SMTP id d75a77b69052e-44fd690c70bmr13334821cf.52.1721805646451;
        Wed, 24 Jul 2024 00:20:46 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f9cdc17f1sm51065571cf.91.2024.07.24.00.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 00:20:45 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Benjamin Segall <bsegall@google.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, Phil Auld
 <pauld@redhat.com>, Clark Williams <williams@redhat.com>, Tomas Glozar
 <tglozar@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>, Frederic
 Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>, Guo Ren
 <guoren@kernel.org>, Palmer
 Dabbelt <palmer@rivosinc.com>, Andrew Morton <akpm@linux-foundation.org>,
 Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC PATCH v3 10/10] sched/fair: Throttle CFS tasks on return
 to userspace
In-Reply-To: <xm26a5i7zi7g.fsf@google.com>
References: <20240711130004.2157737-1-vschneid@redhat.com>
 <20240711130004.2157737-11-vschneid@redhat.com>
 <xm26y15yz0q8.fsf@google.com>
 <xhsmhikwwyw8r.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <xm26a5i7zi7g.fsf@google.com>
Date: Wed, 24 Jul 2024 09:20:39 +0200
Message-ID: <xhsmhfrrzz260.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 23/07/24 18:34, Benjamin Segall wrote:
> Valentin Schneider <vschneid@redhat.com> writes:
>
>> On 18/07/24 17:25, Benjamin Segall wrote:
>>> Valentin Schneider <vschneid@redhat.com> writes:
>>>
>>>> I've tested a 10ms runtime / 100ms period cgroup with an always running
>>>> task: upstream gets a "clean" periodic pattern of 10ms runtime every 100ms,
>>>> whereas this gets something more like 40ms runtime every 400ms.
>>>
>>> Hmm, this seems a little odd since TWA_RESUME does a kick_process.
>>
>> I didn't ponder too much on the workload used here, but the point I wanted
>> to bring up is: if you give a cgroup X amount of runtime, it may still
>> consume more than that within a single period because execution in
>> kernelspace isn't immediately stopped/throttled.
>>
>> It means the "standard" bandwidth control behaviour becomes a bit more
>> bursty.
>
> Yeah, more bursty behavior when doing cpu-burning syscalls is expected.
> With the check on exit to user I wouldn't expect anything worse than the
> duration of the syscall though, so it depends on what your test was.
>

That would also be my expectations. That was rt-app, so the userspace part
is mostly floating point operations IIRC. I'll do a bit of tracing to make
sure nothing funny is happening in the kernel.

