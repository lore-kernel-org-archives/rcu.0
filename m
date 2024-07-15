Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66CB5C8FA
	for <rcu@vger.kernel.org>; Mon, 15 Jul 2024 17:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721066240; cv=none; b=gV2hHsJYVuK9d/P3+tv/mlbI8XdHJSJJrkCIU6+bL3awNd02pW4TkpNf1xWc6XELc4eMNfeviSK7V75fSZJFkjIMO/Sl+EwVoYu4Y8Sr0T1SbGP0dVYtIFaASzfKZos1CuDr3FNcFiYYbeVpZ5PxNS54iFHaoMFqn/mzWT9TuEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721066240; c=relaxed/simple;
	bh=ryADqVEKJ5LrZggMqQrQAklaSbHdf0etkTj2L7lfQtI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hAlrrmQlOo7Jgk80Mi3gyGQPI4pdGz2uE29UK1InxpU1WtN8o2kLWz/0YLBxK7CsgXzRGtRlUaSg3iQZLHMWbHQYx85OpZNWcVFgbGh7ghrsJ4s4R7Un5NsKSh1GMUipNg3pRbrA+dWqKraqRpLwX1sf7VMNlGB/lj8h1J6gA0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SsbBQ9+l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SsbBQ9+l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721066237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fi//A5tT5b/KGkVcXcH6Q4HMgHLicOcp8QtJZcCZxww=;
	b=SsbBQ9+lVDgaWmX3oAajCkjxdAUSrpGpRkeUqQVA20LOlmuNg5iSCH7woOXgzTbjKeL8MG
	daCLGuNZZEN8g4VGXdGbpQ4kRTvVs0PDhJxdnuXoLmVL2BspEG7KDwPGr2Jbp+VDab3OOo
	n4040SVrC+ivsPKO5MxcaqV5Q2j+ElM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-S6GS-VbiOtavjKlNrloVXg-1; Mon, 15 Jul 2024 13:57:16 -0400
X-MC-Unique: S6GS-VbiOtavjKlNrloVXg-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-447f8f26834so81227581cf.1
        for <rcu@vger.kernel.org>; Mon, 15 Jul 2024 10:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721066233; x=1721671033;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fi//A5tT5b/KGkVcXcH6Q4HMgHLicOcp8QtJZcCZxww=;
        b=Li865UoEjmYvYkA1W1CJtm9qeAseqJO/DSdfKELvDJExhi0eVP8a2eEIUeO0fiLMgu
         oDtgrQ88STO/uFBBl2Ls9DYg10+rWTBqiXrb/SNSFVvaJLAihgx7NiYArvn0AN2qfqps
         1z4KkhnM3Ndqzh4xEqDcyfPS9wxqUerSLKdb4JU0XN+aC9AFEiSaG0Du6zwB2mn6yrG6
         MSHmLSixnILuRu1ArbEAsYdvdTiTAG9cYa2efJ6qrjDbADakKeFQ1uMH/+NTB9k7SRwz
         i0P/BhNrVdL5h66o/f8o6RqAf1zbKikoQ73Tb6ZrNALR9h/ZLUNI9i4252lanB4Xxyfh
         QLag==
X-Forwarded-Encrypted: i=1; AJvYcCV+ED056fWI6zs9HZFKiaQ0SzolA3WagF6pQ7YB+Lsy8NjfhvKBZt9rShlZZD7TJVSPxLzJCIFkSB2Gz1MohONQEWt7
X-Gm-Message-State: AOJu0YzNLMo1jFTjN8hrva6mmb2ldSPJ/DoY0deadIfTBHtVug35Ubp0
	Gm5IU9vH+81IfgnvyG1qMzvIeRAZzFWVgUqoEvTVo9cJ3rzxOKm3bt9R4fW4DJmavN3ph5fvkwK
	x+Zbq4ar7xAy7F8Tc74TLre3AbCI/jIpyltcc/D7XQdGZcvUk5w==
X-Received: by 2002:ac8:5783:0:b0:447:dd66:8004 with SMTP id d75a77b69052e-44f78baa465mr7495461cf.27.1721066233189;
        Mon, 15 Jul 2024 10:57:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCOt8I0Cmlmhi/T8HwXWf9ta6rZvJj0E1YC1lGNYwYFllGk62SlYpkHNxQVya2Z0VyX86MIw==
X-Received: by 2002:ac8:5783:0:b0:447:dd66:8004 with SMTP id d75a77b69052e-44f78baa465mr7495171cf.27.1721066232823;
        Mon, 15 Jul 2024 10:57:12 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f5b7f8f02sm26970871cf.52.2024.07.15.10.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 10:57:10 -0700 (PDT)
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
Subject: Re: [RFC PATCH v3 01/10] rcuwait: Split type definition to its own
 header
In-Reply-To: <20240712151547.GP27299@noisy.programming.kicks-ass.net>
References: <20240711130004.2157737-1-vschneid@redhat.com>
 <20240711130004.2157737-2-vschneid@redhat.com>
 <20240712151547.GP27299@noisy.programming.kicks-ass.net>
Date: Mon, 15 Jul 2024 19:57:04 +0200
Message-ID: <xhsmhmsmi1qtr.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 12/07/24 17:15, Peter Zijlstra wrote:
> On Thu, Jul 11, 2024 at 02:59:55PM +0200, Valentin Schneider wrote:
>> diff --git a/include/linux/rcuwait_types.h b/include/linux/rcuwait_types.h
>> new file mode 100644
>> index 0000000000000..60a4385a2c368
>> --- /dev/null
>> +++ b/include/linux/rcuwait_types.h
>> @@ -0,0 +1,16 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _LINUX_RCUWAIT_TYPES_H_
>> +#define _LINUX_RCUWAIT_TYPES_H_
>> +
>> +#include <linux/sched.h>
>> +
>> +/*
>> + * The only time @task is non-nil is when a user is blocked (or
>> + * checking if it needs to) on a condition, and reset as soon as we
>> + * know that the condition has succeeded and are awoken.
>> + */
>> +struct rcuwait {
>> +	struct task_struct __rcu *task;
>> +};
>> +
>> +#endif
>
> Can't we simplu stick this in include/linux/types.h ?

Huh, we can indeed. Silly me didn't realize that since all that struct
contains is a pointer, we don't need the embedded type definition for it to
be a complete type.

