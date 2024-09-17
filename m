Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F320F1411C8;
	Tue, 17 Sep 2024 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726583697; cv=none; b=afGg+6stMtc3y+1PUChE5V89bmh4Oh0ttPAF5R3DTPfdUe1qQClfWkK0jT3hIFN8FhVRDBHWluyoFYQSylZje1t5ljtZGopW/tF8Tlm+PUixTOfdXbHgzBh4w1cSA82DUcm37NgFxcmggGx4qWj7dSZZZgkew+VXJARzZ8ON1+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726583697; c=relaxed/simple;
	bh=9LH4hhtpxq15qiORzr3HG/sOKrYBdq0amGrOZmWWOZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bfZCQ/gNz+lgkk1HyPcRFkX33KHvWX8gqeT0l6xwcOBGfUoOa1LhlMJ7cgkdoht1WRSPS9+lWViPBBU5dNQsk2IH65vLBM5+KCNVPvdWAFVttIJmP2+dln5HvxxDFeLElICl84zlnQZ6W1cWQIR/iqhd6OTD7LyvUJdz8rSUAYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnGvmros; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnGvmros"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-45826431d4bso33542111cf.0;
        Tue, 17 Sep 2024 07:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726583695; x=1727188495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FifQGheghn0VyIQYWu5CfuZMuqyOUGFJ5hoSCAZAAD4=;
        b=mnGvmrosK0JO/W/9ZsPtezOI4kdla7ojhQjYcCweYyUJC62S7MlnPY/o/hFz8LOnVi
         d1oepMeDJH3ZI/nTb9RgagoyisiZ8HSc/n/T6IIxYH7pHb1a2+ApiTRsP8nCSr+Jw9r+
         Kn6Ktc0r667SzA4IkWmadZ9LgdC9aoCRHITVHapWh+xz2TDdmSc4600uqtoCQEGWSsQT
         RWbKtd9anrl05meJI0fOb/mi61B9/Otsae+Xwc6YujYFdDn3LfjuEmUcIeR6cxNaFM8X
         XrHELMXoYW1tnKhfhXB59uxN4YMvB0f6P+iyY4iSXAh1FGoWzNE8Yd3lYE37+QeV3+RL
         6SMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726583695; x=1727188495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FifQGheghn0VyIQYWu5CfuZMuqyOUGFJ5hoSCAZAAD4=;
        b=UoV0CQQ4u0ve4ofxoBFEd9R4AuELT27LndgDe5OfcBkMpVa99nid3wFt6q+PfboSgD
         UJOQCaby2Yr4i+ICrsjPK+vtqEDaA60ZPU9U3d3gVT1u+2i1pwmEzhDzoFSfaTWaI2Ul
         rz1PyF0N513pW752xkkir2CPldiJCjTl2gReb9c6dynokGS8rT6j4dhOoBYKJzdWU/UF
         e+Fa3WfjFY2EHbxhQOaOzhENkdFMqHm7DGC7htevvwojb/df4VuQvocNvVDJ62xlrV1U
         fTjJRMfES73dXHKWOcTypLEePFuxxnDVErVFNivqzg6FykAxPRBRFUkeAffO059zRTtz
         dAFA==
X-Forwarded-Encrypted: i=1; AJvYcCV55p1+OYOTYuiafui0wncKCeUgLTd+ESRBHz9BNaXptMhLmOI69wlx1M/Yp1T9QluqphpW@vger.kernel.org, AJvYcCWZfH5RJX0IWTZbjf9qQtR4s8oghujkHlUtxpbZKv8KMtN7rYHabvhMsG95TEBfKJDU501A@vger.kernel.org
X-Gm-Message-State: AOJu0YwYvfjEZFiPtctuB7nlq6BDdRzyn8OD/iiJ7ewQw+fnpHwNgJvW
	ZoeBZvLputOZZrz1IA5LliMNr74fXuOhJMtnXEQ8xHuHDYh+sjzJ
X-Google-Smtp-Source: AGHT+IFEDpEW/g8o7DXp1PGDIP+TLu1QDoRIlmZZLelGzkSOBLY6btV0pEJFbxW5KZ7IqqhJdhL2Fw==
X-Received: by 2002:ac8:59d3:0:b0:458:34df:1e65 with SMTP id d75a77b69052e-4599d29f812mr221153261cf.44.1726583694695;
        Tue, 17 Sep 2024 07:34:54 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-459aacf57d9sm38782891cf.76.2024.09.17.07.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 07:34:54 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9F73C1200070;
	Tue, 17 Sep 2024 10:34:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 17 Sep 2024 10:34:53 -0400
X-ME-Sender: <xms:jZPpZl6Ztqb3wwZl_FzaRy0xP05K5BAqFaikfBHpycuizGo5gWvgFg>
    <xme:jZPpZi7dJzji_MYRzEGLmGKzVDz_b_aIG9aSOZuohNRZ3cDeKeYG8g2e6FiPix4X3
    B3aU0XlUYpW_4tDug>
X-ME-Received: <xmr:jZPpZsfYeHvNS1NcudG95Uo3QxcAisdZ7orUhpEy8l7hvi2o9iOHMwkL_Mp4LA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekjedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnecujfgurhep
    hffvvefufffkofgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcuhfgvnhhguc
    eosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeef
    ledvieetieelffdtfeeiudffhffhvefhiedviefghfefvddutedvjedviefhkeenucffoh
    hmrghinhepghhoohhglhgvrdgtohhmpdhkvghrnhgvlhdrohhrghdplhhptgdrvghvvghn
    thhsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvhedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehlkhhmmhesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epnhgvvghrrghjrdhuphgrughhhigrhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    jhhovghlsehjohgvlhhfvghrnhgrnhguvghsrdhorhhgpdhrtghpthhtohepjhhoshhhse
    hjohhshhhtrhhiphhlvghtthdrohhrgh
X-ME-Proxy: <xmx:jZPpZuKCjtNuYKfhWm6X2eJOLrpSKP1AD5GJoxaA-J9OU7eSFG5jnA>
    <xmx:jZPpZpKK4P0nOpXWYYqYc_A3S0UGQ0rAgQ_kv1WyoEBjzfx3EcUmtA>
    <xmx:jZPpZnzImLBtBXssgGfCZbxF9u960rAvHD71YvXWCYSP74hlUpvOqA>
    <xmx:jZPpZlJWGkLsaF4f8hwt5Tfye61GMSheThRHlISTD9dbA5tF7EGRtQ>
    <xmx:jZPpZsY5DYe5pjpwQtn13lRs7YoChOUhCJJYHtWEMNiA0u12xEzYCaho>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Sep 2024 10:34:53 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-mm@kvack.org,
	lkmm@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	maged.michael@gmail.com
Subject: [RFC PATCH 0/4] Add hazard pointers to kernel
Date: Tue, 17 Sep 2024 07:33:58 -0700
Message-ID: <20240917143402.930114-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series introduces hazard pointers [1] to kernel space. A TL;DR
description of hazard pointers is "a scalable refcounting mechanim
with RCU-like API". More information can be found at [2].

The problem we are trying to resolve here is refcount scalability
issues that cannot be resolved simply by RCU or SRCU (maybe due to the
requirement of an unbound protect duration). Neeraj has tried it in the
scalability issue[3] he has been working on, and he will share more
information in our LPC session [4] (and I will update in the list for
those who cannot make it to the session later).

My micro-benchmark shows the hazard pointers provide very good
scalability on par with percpu_ref/RCU/SRCU on the reader side:

(refscale in x86_64 + PREEMPT=y, avg reader duration in ns)
nreaders	1		8		32
percpu_ref	6.95123		10.0869		8.9674
rcu		2.97923		3.243		3.55077
hazptr		8.5991		8.40443		8.5762
srcu		16.7754  	22.4807		20.2406

Things that we know are currently not working:

*	Handling module unload, probably needs a hazptr_barrier()
	similar to rcu_barrier().

*	rcutorture support should be added to catch potential bugs (esp.
	for callback handling).

*	Improvement for updater side performance, currently all
	callbacks are handled in one work, this can be improved by using
	multiple work_structs or threads.

Of course, I might create some bugs, so please take a look. Also love to
hear anything on the current API. Any feedback is welcome!

Patch #1 is the implemenation of hazptr, Paul and Neeraj contributed a
lot, but all bugs are mine ;-)

Patch 2-3 add micro-benchmarks for hazptr and percpu_ref.

Patch #4 is a simple test I've used for development, I put it here just
in case someone wants to give a quick try, eventually, we need to add
hazptr to rcutorture (or has its own torture) for more testing.

Regards,
Boqun

[1]: M. M. Michael, "Hazard pointers: safe memory reclamation for
     lock-free objects," in IEEE Transactions on Parallel and
     Distributed Systems, vol. 15, no. 6, pp. 491-504, June 2004
[2]: https://docs.google.com/document/d/113WFjGlAW4m72xNbZWHUSE-yU2HIJnWpiXp91ShtgeE/
[3]: https://lore.kernel.org/lkml/20240916050811.473556-1-Neeraj.Upadhyay@amd.com/
[4]: https://lpc.events/event/18/contributions/1731/
[5]: Herlihy, Maurice, Victor Luchangco, and Mark Moir. "The repeat
     offender problem: A mechanism for supporting dynamic-sized,
     lock-free data structures." International Symposium on Distributed
     Computing. Berlin, Heidelberg: Springer Berlin Heidelberg, 2002.

Boqun Feng (4):
  hazptr: Add initial implementation of hazard pointers
  refscale: Add benchmarks for hazptr
  refscale: Add benchmarks for percpu_ref
  WIP: hazptr: Add hazptr test sample

 include/linux/hazptr.h       |  83 +++++++
 kernel/Makefile              |   1 +
 kernel/hazptr.c              | 463 +++++++++++++++++++++++++++++++++++
 kernel/rcu/refscale.c        | 127 +++++++++-
 samples/Kconfig              |   6 +
 samples/Makefile             |   1 +
 samples/hazptr/hazptr_test.c |  87 +++++++
 7 files changed, 767 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/hazptr.h
 create mode 100644 kernel/hazptr.c
 create mode 100644 samples/hazptr/hazptr_test.c

-- 
2.45.2

