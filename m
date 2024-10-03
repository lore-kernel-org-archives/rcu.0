Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E606812B93
	for <rcu@vger.kernel.org>; Thu,  3 Oct 2024 01:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727920234; cv=none; b=tjqaZ+gojv27WVE9ORibtnUnItFHX71QvF+nSaaBQlJ+4LgmzKT2yTcuadmBjxHug9ksUMiri0HUngvB95GmjOlQo5maFPwDJ+FX5RqMgGEep0K8jEt6jMIoUy+ztLXUj3ka7tJW25HTzSTIqIR9uKFTz4VcVllm95E1sQ+44v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727920234; c=relaxed/simple;
	bh=z/negRqsG6gkntIZJHtSlJSuVmE0XE7frCZfd1hTztk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huLn14o99oX2jhweyDXnbMVRap2GDQ+gEB7Jh7ul3L9J501ZjEG2ocs9zmIWUJ/8SoVDId18Sq/qh0Wp6qXvwYSrNixZT0IfoYRXDnH7+yhTvxHHf9I8tzzIxNH+3ARLYHiS+enyKkjQCSL1ql59uKoy+TmGiZibi1UHf7xWkig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=B9G0xVoE; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="B9G0xVoE"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6cb2458774dso3467616d6.3
        for <rcu@vger.kernel.org>; Wed, 02 Oct 2024 18:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1727920232; x=1728525032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TW60IUTPehz0g12Pfaz6AL2tkt66MvpF0k2D1aaI7NQ=;
        b=B9G0xVoEcEeQ85zHyNDamOTrglCA2uOfCFNr5fSQNw4ECPeYPmiYDTu8VdafIf1JLt
         a7baUCHolI4+z2It3jo+2gbfXwTsj/Kzvtc/4Jt4BE+r748xa9OcsGz4hqbHbAQFD7HS
         TnMDlkv0optlsb82stoUDswcoY4+gchLehAJVbDsoocIZPlsUDGl+aVP0WGEGZLl/oco
         /qIAgy7vx2SO1Z3YCgE7h7gSk08dKklq9mn69ABz6p1qexZ0mcbCJA+ebP0lDVaY5GP9
         xBL3PyguT+LZ0lZj0ih4+z2X8qEJS4CbMfa1Wr1CgV2ahaamNoILCWNqbCdjGCJsh3H2
         HhWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727920232; x=1728525032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TW60IUTPehz0g12Pfaz6AL2tkt66MvpF0k2D1aaI7NQ=;
        b=M1WrZ6Als9B5nMTR4tBy+ez9zFVo538NCxBOXrBtvW2NgImOwK3EapeD71UPsWv/NO
         ujgMRZ1s+O8aWDSOjbL5ZNJcnc2x4/77Ner5S+B7SzMli6MLkOFVVNcxfIMzTkgxjYbA
         mzjMg1e8S1LZlkZQ/5N3NUc+rJzd0o0otV/F+RZKEnOdpaJG2/IWFVOB/variYjXp0u9
         nl9Djk2MF1BWmZzHLd0WFmvb5UWDzTUKD4vxEj4dxSX0qXlfTsaXyWVzFqvuVL4DT3hW
         xqISSx86CgQYmrztq0D/2/HSxUnrrwSm7qeNfXmHKbPESDFIIAsJPJ32b8QDqfTa4vUX
         /MOg==
X-Forwarded-Encrypted: i=1; AJvYcCVTHH5rjAcGNQPEBAHzq0hI8Ylz05sz8LbdMniePk3pqYliQjOSf3d7oSGlB9Q0CFC3Pss=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXZ8ARzY0xoM3nK8fvMkrQTnYUn7iSKjiSY1jZUCNcTWZi58ae
	8bjpng23BI9ka5KpcTFLlmbeq3xQw8nvtt0gc6Mq9XAji2R0+fKo4kuODJXmwg==
X-Google-Smtp-Source: AGHT+IEv26iq8/1ZOyYGTcYuUxX/o0z7IncEd2xD4JiQFmC+bd8vOYXdTa6iFRK06pFUDggHzbTHhw==
X-Received: by 2002:a05:6214:4890:b0:6cb:5105:8d4a with SMTP id 6a1803df08f44-6cb81a9e3d2mr76906956d6.34.1727920231847;
        Wed, 02 Oct 2024 18:50:31 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::1384])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb9359bfe3sm1286326d6.9.2024.10.02.18.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 18:50:31 -0700 (PDT)
Date: Wed, 2 Oct 2024 21:50:27 -0400
From: 'Alan Stern' <stern@rowland.harvard.edu>
To: David Laight <David.Laight@aculab.com>
Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>, John Stultz <jstultz@google.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	"maged.michael@gmail.com" <maged.michael@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>, Gary Guo <gary@garyguo.net>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"lkmm@lists.linux.dev" <lkmm@lists.linux.dev>
Subject: Re: [PATCH 1/2] compiler.h: Introduce ptr_eq() to preserve address
 dependency
Message-ID: <68dc00b3-1ca1-42bc-8f1e-78ace10e4d64@rowland.harvard.edu>
References: <02c63e79-ec8c-4d6a-9fcf-75f0e67ea242@rowland.harvard.edu>
 <9539c551-5c91-42db-8ac1-cff1d6d7c293@huaweicloud.com>
 <2cdda043-1ad9-40cf-a157-0c16a0ffb046@rowland.harvard.edu>
 <5d7d8a59-57f5-4125-95bb-fda9c193b9cf@huaweicloud.com>
 <82e97ad5-17ad-418d-8791-22297acc7af4@rowland.harvard.edu>
 <ea02ce2ce8a348efa8d461f84f976478@AcuMS.aculab.com>
 <2b1caba3-48fa-43b9-bd44-cf60b9a141d7@rowland.harvard.edu>
 <22638e2fe1274eb0834fa3e43b44184e@AcuMS.aculab.com>
 <d192cf63-a274-4721-968e-a2c098db523b@rowland.harvard.edu>
 <e39c6e5975f345c4b1a97145e207dee4@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e39c6e5975f345c4b1a97145e207dee4@AcuMS.aculab.com>

On Wed, Oct 02, 2024 at 03:24:45PM +0000, David Laight wrote:
> I think I know what you are trying to do, and you just fail.
> Whether something can work is another matter, but that code
> can't ever work.
> 
> Inside if (a == b) the compiler will always use the same register
> for references to a and b - because it knows they have the same value.

According to the other people in this discussion who have actually tried 
using this code, it _does_ work (at least some of the time).

However, I'm not one of those people and so I leave it up to them to 
decide how to respond to this critique.

Alan

> Possibly something like:
> 	c = b;
> 	OPTIMISER_HIDE_VAR(c);
> 	if (a == c) {
> 		*b
> will ensure that there isn't a speculative load from *a.
> You'll get at least one register-register move - but they are safe.
> Otherwise you'll need to put the condition inside an asm block.
> 
> 	David
