Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F17C2FCC04
	for <rcu@vger.kernel.org>; Tue, 27 Jan 2026 10:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769509088; cv=pass; b=dAAZV9GCo4ZleeuatDIg93TwJU163MQtQN2HStgUOQFXJ2OxjSn/HvKep/+Es5AdLNG/psXEn2TGzMoQ176+GyhEbAWBxSnV8HeDD+iScJOcFszQxDmJZiuq9GvYp01LGSISXv8l/i/J6Ag8VR+lCJi9RFNGbFcZhe8se+Qky9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769509088; c=relaxed/simple;
	bh=9eWZA1QTRdZDTddGYL8SlE552QBQW/sLGGoi37wJCfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PNARuzBipIPQoSgg6BSUD8DxqS0Hh+PyPQeOBsG8KA2kcgwWbCcJJCYZrsD2iBoswV+FDHftF7KoGr6ltWGOykjiI19x0DQLotQw/RMoHN7W9MPDsH127C007/qQSHiCKtf/fAo57IrE7EMQn0XwGK82EBGeH4cPiOXxu3oEvvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0CBOsHD/; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0CBOsHD/"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12336c0a8b6so1801189c88.1
        for <rcu@vger.kernel.org>; Tue, 27 Jan 2026 02:18:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769509082; cv=none;
        d=google.com; s=arc-20240605;
        b=Xoun2LQwLYD2ztGNSF07lPsgD/jTeL9I40+DDlO2AD4a5ZSfs4Jc8mJf75XE4BUM+h
         oHl3rEr2BLqJa99QktBIPao+7mmu7ds/dw1xE/3hGVf7k7abhexlv9TEFN11wVIrp9Nw
         hN6Ig7mQO3t+w4kxF3fGidEQ5MExAOV5zBOmZlIwafBl33N3ROjPnUsZLx6idnfWleIy
         sftSLbkCAdcZH7JiWypgKbKZ6p2P3ecxtBlVlAKgc8upGfno+HKALh8Jtx40JNjKjJd6
         LWQvCPFfnJrhOuuNVyu/vSlkx2hqmMDLas9Od+9sEKilKgRIaDY+3PseqaQ8GVsD48Rn
         qs+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9eWZA1QTRdZDTddGYL8SlE552QBQW/sLGGoi37wJCfo=;
        fh=R11h5PpWAmvj/rYEmqVAxNvhXGmD4mPQ61e30wj1Dq8=;
        b=REqT60X4rznXqHhOhoErZS+yp1YQ4VKv4cBjuIth6RiP4ldiPm90Y6mnQHhUsigWm7
         eGDv3IuUZRYlPoFy0QBOC1kUY2+KZX234HEiUE3A98RRrCrW7PXqNo7IlIDQ/GJmY0ch
         slQ9Bx9J0JpWwHbYlyKxcMqTbHDERcL8kn2HXc/nItEWqQTloieUIFES7j6xAmf6UIpz
         Cu/ba49ALD25iF9mwWqfZr0/tdcrIArwo+ca3G5QHtt4cByHljQblmEl1B1hdZnMRtaO
         UzYFpRLPF/0anAQ9mp8LLzTKTJRDOqOazPz4VRDtOxCuYgYEkKyB9YqWnmUvlKh49nfL
         Y/sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769509082; x=1770113882; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9eWZA1QTRdZDTddGYL8SlE552QBQW/sLGGoi37wJCfo=;
        b=0CBOsHD/uKOv95aR8OTAbtRyWBxyLJ6N1fESKzC2veqVx9JPRAR/Gsg+n8VRUW2Hp3
         EG6v3t7dFFHmx4Qe9/enHqvAYc/MN+zbW34Q0dIEP/dBnHyBwmTXLN/s4AgkzfrYowyK
         TS9/3JGwU153BB0kkOIvZ5Xtjd+Bp8Z4TnxiAJfhMEvuCB4na3T6n77gyhHa/UDpEb0b
         IgALtOGmCw2o5+TNyDxryyFP5U2h1On49wPhmsdnKC83ra3MXi1Xx96djhullUZFhEEf
         Bu8bIyKcXqPDpnJ079sq0S/S0xkr66rrSYp7sxWe3EDfxUs2fpKiC1ykKYevzeLX0nO4
         YmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769509082; x=1770113882;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9eWZA1QTRdZDTddGYL8SlE552QBQW/sLGGoi37wJCfo=;
        b=qngaIiO6jbu41y6znZBlbjS1DKOp7fzNdd2zEU82bZFfo/vjmPkZ65TKPI75Tk5Fdj
         tqG4CkqhN3ihMSd9riIq8KzARPGmRd3t2tejFEHeurNwaZNgpI2q05nRCH+3wwxVAItl
         4BnT4LV+/P+P8mGZvYSyuqu3TUorqibM7m5seJiG3OO9K/OFtkKyEToaz14jAdyMk4qG
         g8GBr0UsU7WekTx9tU5LYDzVrd3fzH5wcQRkgJ8hyzdG6FjOXmNVizrncxi+4jYDDPGp
         Ef5GzqPWPORI0YFGqBF36SQ+JMpIwTaH+BOsOPPkmrJx7ZMi0i/knx/j1Q9OZIP+i7QD
         DvRw==
X-Forwarded-Encrypted: i=1; AJvYcCU7LKR7T/qZUvWrmdSlMi7J0x8LUZSqXDgPUNOZ+1tgCMoqBmqWjhLyMj5GomKJAuSENTY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7BEeBeKq/MRve3Ep95poFXsjapdLXD9QlFlMUGPIYWMifhWPG
	SQXqD612i4N4ZAUJR5w1G8u1PkomED4haUCp3/JfBalVd/Y2AXzOPTu7ex1hm68ylumZlxbdSDi
	y4R8upXir+CBD+7dO2aq67ffe6UeFmxbB2oqQ4udA
X-Gm-Gg: AZuq6aJn2yOyEY/DSreSIl+X/opRKl5gzRDAleYnEyo9Pv1ldTtmTKHQeAJeme8Q+yC
	zcDEgahR9l/eEG+umJgTTtrmd3RLTqhdQVMZXga9g5r0nD4bGjCfFYmewPYRE6HCSmcXYiE51QU
	YuRSr0IfLvQEMQ14XJUYTiKAW1KKPPX16RtG+9uFQpWIfDH0T7GS8iDZK/EMfSE0qH3sMhFTLpl
	V3/07bg4kZ6pVb3iLS4y/1W/M1hzC+1oN60rOwTd1Qi1qftbKdW0/l3yvk/Okt7fIjCuIzUcDg0
	WselWxcsAVt+Iiq+Y77W3gVrwA==
X-Received: by 2002:a05:7022:6985:b0:11e:f6ef:4988 with SMTP id
 a92af1059eb24-124a00cd55dmr806676c88.36.1769509081547; Tue, 27 Jan 2026
 02:18:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219154418.3592607-1-elver@google.com> <20251219154418.3592607-7-elver@google.com>
 <0c2d9b69-c052-4075-8a4b-023d277b8509@lucifer.local>
In-Reply-To: <0c2d9b69-c052-4075-8a4b-023d277b8509@lucifer.local>
From: Marco Elver <elver@google.com>
Date: Tue, 27 Jan 2026 11:17:24 +0100
X-Gm-Features: AZwV_Qj2UVNnjgQTvKRMxq0N2rMz8K4yMXQyPWTkZbJrWul7iRYbem2vd2u4cZs
Message-ID: <CANpmjNNHmOzaCSc9hQJNuzNVHXA=LRgXB4Q69FNk6wBuuJGdAg@mail.gmail.com>
Subject: Re: [PATCH v5 06/36] cleanup: Basic compatibility with context analysis
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	Chris Li <sparse@chrisli.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, Bart Van Assche <bvanassche@acm.org>, 
	Christoph Hellwig <hch@lst.de>, Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ian Rogers <irogers@google.com>, 
	Jann Horn <jannh@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Johannes Berg <johannes.berg@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Triplett <josh@joshtriplett.org>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <kees@kernel.org>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Thomas Gleixner <tglx@linutronix.de>, 
	Thomas Graf <tgraf@suug.ch>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org, 
	linux-wireless@vger.kernel.org, llvm@lists.linux.dev, rcu@vger.kernel.org, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Jan 2026 at 11:14, Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> +cc Sid for awareness
>
> Hi,
>
> This patch breaks the radix tree and VMA userland tests. The next bots didn't
> catch it but it seems now they're building the userland VMA tests
> (e.g. https://lore.kernel.all/202601271308.b8d3fcb6-lkp@intel.com/) but maybe
> not caught up to the issue this one caused (fails build in tools/testing/vma and
> tools/testing/radix-tree).
>
> Anyway it's a really easy fix, just need to stub out __no_context_analysis in
> the tools/include copy of compiler_types.h, fix-patch provided below.
>
> To avoid bisection hazard it'd be nice if it could be folded into this series
> before this patch, but if we're too late in the cycle for that I can submit a
> fix separately.

Thanks, I saw. I have a more complete fix I'm about to send.
