Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1695589A
	for <rcu@vger.kernel.org>; Mon, 15 Jul 2024 17:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721066299; cv=none; b=YU4Mx1cvJsMXzisqSlwzFM1Cd8Fg5neHTdvRLCsTbiqgplnGsMGrD52mrkw5SAt668yLAmt59guFicbbKTtB694VMSGz3YIReboWAxf0XbEmcHi8gcDXhphXj+RWvXnT+v4WU+cXvwXOIJTDJ5EX34XgSG6+Jg/im4dU+2lc284=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721066299; c=relaxed/simple;
	bh=AvF80KexMQDpk2JmVtnfZ8FRWCV5QwoiXFtn4yq56xw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YLDnhorD8iv3j+zCtWm5t485/usHXyRk7C3YvJ+1oz1hRFtGrCvmsGAi6qv7CgXY4dGJA8u2/Kd5pATjR3KYDtFW0R+2cQT7grN+JADwR/K8iDMIshXIVNFAwG1kuAG9FdKSSXNRUbqQFSjDV/OuWEmCX1SSfsdolk6twIfDtzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ajra8A6Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ajra8A6Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721066297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m56+rxvwF7PS34zi6GKHWHULJ2zyJfG14sY0J2ksKZc=;
	b=Ajra8A6Zw53RZ+aoMPrDYvxInD4MrPQ8vZo4r/5E7s1SEpwSZKFcy9/Ak+27ElTVRPJ+05
	92jIYSdjw+JoSw2/tdc7pl1E0XmrNs6hX5khlemORoXrYzNv9kYRMxCmr9xx/5Y9GWsTJD
	npKITkjUBbhAC132Q2NY6MoZM3b4ros=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-s6LxNgkQNvqsAsLkClCLcQ-1; Mon, 15 Jul 2024 13:58:16 -0400
X-MC-Unique: s6LxNgkQNvqsAsLkClCLcQ-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5ce44027232so1371149eaf.2
        for <rcu@vger.kernel.org>; Mon, 15 Jul 2024 10:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721066295; x=1721671095;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m56+rxvwF7PS34zi6GKHWHULJ2zyJfG14sY0J2ksKZc=;
        b=Xw2gOEH9eTgZH8Dop+AvxF8GBwOTvV/RSmyPIhhyGMzZ6vpfyrZapdBTsj7XCkpCt7
         GMY0O8PbV/QoB99/StwrZdJ2Lz2ulrYuEMKQC9FBcLHqrjBEuTKne0uz+fH2VwDV51QO
         1zT90TODZSzs9FrockYMXuVyPafA3IR+CLvIku5QT/gBzoUt43sF5VmNedYIJYBv8etV
         devS1peDKvx6f4S6IAVkqatkz43pFqEG15VZpes8+UuyqBzPe51omH7ZuDTrwIlKK/Pf
         SUlIhCovEx3S6x7OYToq7N+u6bAwXktnYq6YGzfRYc8Pcg13Xc3+iWP4b4+yz8aQ82y5
         8G6w==
X-Forwarded-Encrypted: i=1; AJvYcCUZzcP7udUTrSyRcIVpbGiMraQWvBRl1NtVSkHNoH5TJNmra+DJlbDNpPwRS2F12/zVof7um9aAyCjK8EuQa8Fqh+01
X-Gm-Message-State: AOJu0YzQuufg/GeBXBrsuuLWnLM9caPHTLKQJYXgoWHGBvuHfgO7dnXo
	O8K9SRNQQJzmUk4sz23WYePnwqZDBOx0f34RnMuBrtiRXK2bf4gdwHLnDNPPPtC8F3N9G2EritB
	9kq61dGyk1OD0KR/j/8eNcrtr5O6YGxHPjrajDRrSP9TXZi0V1Q==
X-Received: by 2002:a05:6820:1f04:b0:5ba:f20c:3629 with SMTP id 006d021491bc7-5d2550e856dmr375065eaf.4.1721066295741;
        Mon, 15 Jul 2024 10:58:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEG5CzS5J/7JXwEverR0AO7CeHZPjLkM66rbdlkFDHt3Eox0nNIENp/ISPHEY2JS1AuyliWBQ==
X-Received: by 2002:a05:6820:1f04:b0:5ba:f20c:3629 with SMTP id 006d021491bc7-5d2550e856dmr375021eaf.4.1721066295343;
        Mon, 15 Jul 2024 10:58:15 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b761a53ffdsm23438616d6.119.2024.07.15.10.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 10:58:13 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, Ingo Molnar
 <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Phil Auld <pauld@redhat.com>, Clark Williams
 <williams@redhat.com>, Tomas Glozar <tglozar@redhat.com>, "Paul E.
 McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Boqun
 Feng <boqun.feng@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Catalin Marinas <catalin.marinas@arm.com>, Arnd
 Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>, Palmer Dabbelt
 <palmer@rivosinc.com>, Andrew Morton <akpm@linux-foundation.org>, Oleg
 Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC PATCH v3 04/10] sched/fair: Introduce sched_throttle_work
In-Reply-To: <20240712152158.GS27299@noisy.programming.kicks-ass.net>
References: <20240711130004.2157737-1-vschneid@redhat.com>
 <20240711130004.2157737-5-vschneid@redhat.com>
 <20240712152158.GS27299@noisy.programming.kicks-ass.net>
Date: Mon, 15 Jul 2024 19:58:08 +0200
Message-ID: <xhsmhjzhm1qrz.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 12/07/24 17:21, Peter Zijlstra wrote:
> On Thu, Jul 11, 2024 at 02:59:58PM +0200, Valentin Schneider wrote:
>
>> +void init_cfs_throttle_work(struct task_struct *p)
>> +{
>> +	/* Protect against double add, see throttle_cfs_rq() and throttle_cfs_rq_work() */
>> +	p->sched_throttle_work.next = &p->sched_throttle_work;
>> +	init_task_work(&p->sched_throttle_work, throttle_cfs_rq_work);
>
> Yes, init_task_work() does not write .next, but can we please flip these
> two statements and avoid me having to double check that every time I
> seem them? :-)
>

Easy enough :)

>> +}

