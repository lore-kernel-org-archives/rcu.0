Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4549F288DB
	for <rcu@vger.kernel.org>; Thu, 26 Sep 2024 16:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727367202; cv=none; b=BcdYBHDhuKKaKmKR5UW7oLgSkqGDLHSVtoJTnlW8KnvmL56QAm3g85z1BwWYz/cvgjewirgoaIBaspYY5lP5avBpdcY4iq47Uebke3gm3Oo+CH7LyBwhJdE+1tMTaDa8owf8HnKpgOlBTAQ0uLO/UzJO5mD3cTCpjAdQbMhg4E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727367202; c=relaxed/simple;
	bh=b/AkQ6KC/9/lXddy+98mjZVGNz2jCIw0oGNZw2EAKto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wr44K0qEzPlGYY/CdGdLEVVP/TwWw++mPtDkk4tPnCACHiEbNbnnn88pxu9G+EBH8E+PVPrRvExwS07W5YcrOC3bC6wiQyd6SPyScFGpgWr6x1HXITRZLTBW1mf/F7Pekw+kzH78PSz6wnwcxeicHUqMMJpG1KQN9s68bOyvoGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XuGZCNKy; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XuGZCNKy"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5365a9574b6so2018678e87.1
        for <rcu@vger.kernel.org>; Thu, 26 Sep 2024 09:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727367199; x=1727971999; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QXnBUq/9ghYv0bNYvo4uDCfOpMdq8coMpre7nUUI9wE=;
        b=XuGZCNKyThI6pV+XtGz/YSJWu/BbCfILCXOy/06ICqmP5E9NkI0MrLvOE338o1NPGm
         Y5asItQWnqG5HBzIr22HrluLeJLREAR8pszbeyRWGw8grp5pV+Ey+RBtKe9rAzushAsb
         xUZJ+3+NExCx41Y3V02LOJMZnuzONYQtqd5rQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727367199; x=1727971999;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QXnBUq/9ghYv0bNYvo4uDCfOpMdq8coMpre7nUUI9wE=;
        b=Ifb+cQdHZxP/91aMKTM8B9KZdZDS2QFnZR6A3wAgvHIM2VfFCLUjQwKRcTG1LJwyJz
         Qca53EtLsUgMZPQruv00i1xwoXZBtVVDfAIjHQxRm2awQ3yBhP1HqT+R3rnGsI1tqzxE
         aajV/of7MwF1q49kDd/CKpA/Vdfu317AJ1TW585gjCp88L7uEDIotyLnK0GKQBtHoBaU
         qgjhbgKAji8djco4MVRxxcNyfi2BbtW+RNSoSovcaSDdFJPkPHaDek3lJDlwaaMWZRug
         hlJpv91AUJWe3QbrL9AbJrUCJaF8S6AzOlqTyMZ64WkG4n8O1yS7TQeNJajyRuAVN/t6
         OR+A==
X-Forwarded-Encrypted: i=1; AJvYcCVzQ0fLss7VS8Jrg0j1XsWEUCskMBknQIacmkrFBfT53Q6cHuYbCYNcW6IvP6hhl9bX4JQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW2OErnWvDQUoFhYjVr5uesAYr/QT3vVnRUFfBRmUl1DZPPIDa
	OKZlT5YWdGD1qrpuaoovtGf737Zu0zxc5MKQV4gT/B6Jx0IchA9bHKSesTHGn/IqsX7sceeZpHJ
	Vs82gjg==
X-Google-Smtp-Source: AGHT+IHFEQE78EGrGmbIoaNBLrbPIDTFuTkS2euKrIIfts5E4LsmaaKUJbBRC3uWoB8Hau1MjHZaIg==
X-Received: by 2002:a05:6512:2207:b0:537:aba1:16be with SMTP id 2adb3069b0e04-5389fc7d1a0mr131686e87.46.1727367199055;
        Thu, 26 Sep 2024 09:13:19 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-538a04328aesm707e87.173.2024.09.26.09.13.16
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 09:13:17 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5365a9574b6so2018560e87.1
        for <rcu@vger.kernel.org>; Thu, 26 Sep 2024 09:13:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWGC/DT5lUmffy2oPAyV1QiMMuxfGJrtlcpBoWTOpeli+S3m6uQprdNhRYx+3EhxHpXnZc=@vger.kernel.org
X-Received: by 2002:a05:6512:1113:b0:536:53e3:feae with SMTP id
 2adb3069b0e04-5389fc34426mr138492e87.11.1727367195995; Thu, 26 Sep 2024
 09:13:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240917143402.930114-1-boqun.feng@gmail.com> <20240917143402.930114-2-boqun.feng@gmail.com>
 <55975a55-302f-4c45-bfcc-192a8a1242e9@huaweicloud.com> <ZvPfmAp_2mDkI3ss@boqun-archlinux>
 <f5aeeeda-c725-422a-9481-4795bd3ade0f@huaweicloud.com> <ZvPp4taB9uu__oSQ@boqun-archlinux>
 <4167e6f5-4ff9-4aaa-915e-c1e692ac785a@efficios.com> <ZvP_H_R43bXpmkMS@boqun-archlinux>
 <a87040be-890b-4e83-86bb-5018da4a894d@efficios.com> <48992c9f-6c61-4716-977c-66e946adb399@efficios.com>
 <e2733938-06fa-46c3-8839-4349fe50d46f@efficios.com> <2b2aea37-06fe-40cb-8458-9408406ebda6@efficios.com>
 <55633835-242c-4d7f-875b-24b16f17939c@huaweicloud.com>
In-Reply-To: <55633835-242c-4d7f-875b-24b16f17939c@huaweicloud.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 26 Sep 2024 09:12:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjL803+FxtAPSGrWqThGQP5cCHzzwZJFq+-fkgt5DQ3VQ@mail.gmail.com>
Message-ID: <CAHk-=wjL803+FxtAPSGrWqThGQP5cCHzzwZJFq+-fkgt5DQ3VQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] hazptr: Add initial implementation of hazard pointers
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Boqun Feng <boqun.feng@gmail.com>, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org, 
	lkmm@lists.linux.dev, "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Kent Overstreet <kent.overstreet@gmail.com>, 
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com, 
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Sept 2024 at 08:54, Jonas Oberhauser
<jonas.oberhauser@huaweicloud.com> wrote:
>
> No, the issue introduced by the compiler optimization (or by your
> original patch) is that the CPU can speculatively load from the first
> pointer as soon as it has completed the load of that pointer:

You mean the compiler can do it. The inline asm has no impact on what
the CPU does. The conditional isn't a barrier for the actual hardware.
But once the compiler doesn't try to do it, the data dependency on the
address does end up being an ordering constraint on the hardware too
(I'm happy to say that I haven't heard from the crazies that want
value prediction in a long time).

Just use a barrier.  Or make sure to use the proper ordered memory
accesses when possible. Don't use an inline asm for the compare - we
don't even have anything insane like that as a portable helper, and we
shouldn't have it.

                   Linus
