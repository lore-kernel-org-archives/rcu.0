Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BC1172BD6
	for <rcu@vger.kernel.org>; Wed, 18 Sep 2024 07:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726643946; cv=none; b=gaWQt9+Kw6v2UnLGqwZG6zIy7+eWKLdEkl/0Do+N2XkdtSELvR194MHTnhL1/2PlC0zNaZj2ByYqyjwHzza+v22YKjOqWHsUB24st2meArnl7Jo40SlDScGF2FZyUFNsf5F09/LgBsxHLUbsPpcTD/8AykjLpnX5nHW5LmddOJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726643946; c=relaxed/simple;
	bh=kTPeIU/j5jUeqN41PXaxQLwE/1Uka9ApKWzgFyfK52o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kIVKnEFbx80pq7BeP4MoxoyDXK4q7wI59IQCx5ktqYJcjunQjcF7QJICnwaJs+jzybhDzfgmMhc0cUt/wB4I+DJR5/Z+E7SLtEA2QoidXrf11xrkDzBfRK3sh5FzF3o3RTArTy1fp8gqc8lX+gqaiJMG1JFShrHDYIxruqXy2kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YbdIQ4a5; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YbdIQ4a5"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-374c3400367so4716158f8f.2
        for <rcu@vger.kernel.org>; Wed, 18 Sep 2024 00:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726643943; x=1727248743; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TqYtJ8YuLXQL4jCoAoDYqm0N+vE0UnC4CwyzicEGN7M=;
        b=YbdIQ4a5KegNtN3dJhQZp17f75i1yoMkfIqGIiT/dzFItpbEPxpVBJQUMxvLCpOxA1
         0vlnamgEsK6LnQIEQHTY5/RsGDcLRnqh7a9QIHEaz04cMO3bUyiQMAopanDnu+SW8JVu
         wOxeHA2HfTrkLarQmTy25r6jlOmTTED6WPris=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726643943; x=1727248743;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TqYtJ8YuLXQL4jCoAoDYqm0N+vE0UnC4CwyzicEGN7M=;
        b=NFfMflAnXApP52odAhtHczTlF5PDOmnZdA+fK1PLO4aiBtAqpeODZL4/eEo9MsJDtV
         UHm67uI5/eMgifXEGVPP5Be8ij05m/8OexRNEeNwWQx/t5T6gmrHovUTNALMigYbsUGL
         Pd4Ai63hO5rvFn6SQaVMgb5qoz40q7ixtA6fxXLoF8doaBqoEXRG9MCTXQcSsWHJp7T+
         YLZ0m3HTe6tYGKR1DfN3m27oHb49Lir8wJ/TMBwY6IMAGqbBXEjNgK8DE266VetVK82I
         CjsEz+N/IOmieXaN+k68r80xeLAmqsuJoZIgo4/bIOlKp8t79saRVgNtk3mF7/NJlrcU
         eOMg==
X-Forwarded-Encrypted: i=1; AJvYcCXM/TM5FNJLH5lnvhzAXn5a5t4MbczOEqzEmZWJTXcm9sBqqqRRFTmD5nTstgd1Sl8yez4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGQI6wKAM8CwQ0GcaCNSQiBccIWjafBNyZ3Zh0VTBqJdH7Y/G8
	heauAJorjf4XNPqAJXwwa4iWFnOkqkH7+jQ7xXfqUOi81BtpxoBaxnqpCZlslYUYSngxCg9My79
	1rWcIgw==
X-Google-Smtp-Source: AGHT+IETrnPkrNHvABk6Nq2h9xNFK6GoySxlV6MgDpNgngNwa4YSLTZIh+okQ8xn0r4bEo7W3F8oVw==
X-Received: by 2002:a5d:4589:0:b0:374:c9f0:7533 with SMTP id ffacd0b85a97d-378d6236beamr14614830f8f.41.1726643942852;
        Wed, 18 Sep 2024 00:19:02 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612df75csm549844966b.149.2024.09.18.00.19.00
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 00:19:01 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8a7903cb7dso412245866b.3
        for <rcu@vger.kernel.org>; Wed, 18 Sep 2024 00:19:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVx9wqnjSlII1f2SNPZtHJew7+DS3mATsZ8/8PEV8w5XJC5Z/k0SPllWEnlOMLLPul+TKo=@vger.kernel.org
X-Received: by 2002:a05:6402:4310:b0:5c4:2d14:c725 with SMTP id
 4fb4d7f45d1cf-5c42d14c8b6mr21424243a12.2.1726643940613; Wed, 18 Sep 2024
 00:19:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240917143402.930114-1-boqun.feng@gmail.com>
In-Reply-To: <20240917143402.930114-1-boqun.feng@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 18 Sep 2024 09:18:43 +0200
X-Gmail-Original-Message-ID: <CAHk-=wi76E2xxvOaZtgN2FK9YKmbK1ru_1atL8eBCs34z7UigA@mail.gmail.com>
Message-ID: <CAHk-=wi76E2xxvOaZtgN2FK9YKmbK1ru_1atL8eBCs34z7UigA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Add hazard pointers to kernel
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org, 
	lkmm@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang1211@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Kent Overstreet <kent.overstreet@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Sept 2024 at 16:34, Boqun Feng <boqun.feng@gmail.com> wrote:
>
> This series introduces hazard pointers [1] to kernel space. A TL;DR
> description of hazard pointers is "a scalable refcounting mechanim
> with RCU-like API". More information can be found at [2].

Please give actual "this is useful for X, and here is an actual real
load with numbers showing why it matters".

We don't just merge random infrastructure without a use-case and an
argument for it.

                 Linus
