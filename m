Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA086E61B;
	Thu,  8 Aug 2024 03:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723088330; cv=none; b=XQhxR7wS5OU6bnYow7ouSepYnaKc+5kDP/o7vrs++CvVP+LjkMJdRrMATgl+yp8EmrV5ImWGqK2RwHU1kiC1smy69yR/Qq43NHPeE5JcSa0/7FFwg+VL2p0LUSFcKy2/uMoYzhXAPsoYAe7K+/J7FO7hxDkRrCA9HPiU9I+cWy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723088330; c=relaxed/simple;
	bh=o3iCVRfCxyAV4yucGowm2nEoEX1XenIXzDijjdbSHXk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Chppaz4bVIPtORFMDcpo7b5oKwmfoT5wwRTgY5qgEG0eYeb3w3rOg+fmAVb6n/nUICX9ZAWtB72ALYsOpkTasSEqjWI5pqzuXLjVaxUn4DOeI02j83t3PxA88yl/X24xERE6+umYwyI9dUp857eFHM8tblpi+TrmVOLa02cWloc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nu9Ty+nm; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nu9Ty+nm"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-44ff99fcd42so2917301cf.0;
        Wed, 07 Aug 2024 20:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723088328; x=1723693128; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3AIlr4XfDvb56arFpxdJIuYixPMu5WSuoxZGudet8EY=;
        b=Nu9Ty+nmFgIM6RG8PxXTdTkNLvepjkTqwP3QDYtWUovedveq5j7Od3CsbbPKIpcwJT
         Jkky70dDBD3MvBzDx3g/YhcJoKHBnlvbw+KOxFlwIL1wRQQctgAy/2fE3F3ctavYphzg
         8CigQ2dEvs3aBjCGeVIAlm6EzfNN/+2uJuUybN7RWdxbzBWCY4jeErkHFZ8+QktMK5dC
         18mwmyM/T+HeQZaB/beUN+iR6kN9MzovLmKxhMwK8nfSJG/fry5pc6k6055f6jUqAF6N
         AgWa35vm0Vz3/VS+bHnLMORyN8S/b5Dd9+yDsqiVRpe0pdjyZctIEGDyRAy7QVRgRP4R
         et2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723088328; x=1723693128;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3AIlr4XfDvb56arFpxdJIuYixPMu5WSuoxZGudet8EY=;
        b=A0//PcCxs4phk3ccsc7HoxxNkmINYQkY5qbe7UWm/6zyVswh2e03OMcvqca/Axle1R
         QtOOb080G0TYMUOo8WcTryCZFkB1CfVKxJigGSJyGJ7APAnglCKcHz/kN5J6kiUsqYh9
         7LY5TvVVwiy99EyGMk7SB6oH/3hE7m29GcVLUwx4KZm77u+yCLruo+/ZIzGReCuRNxAC
         s1WkBnHZDJNgRCUxCJDbnhYJV1thmzmTwrtPUySDZBZjpSFidH8/0xzEAZl02ksqX7EU
         IkfuebEBsrhw+oYQoMa4ZmN3dw+uCnNBJLyhUxFxObBpOiJ8h84NDc/SQ5FPGvBPy7KO
         9v5w==
X-Forwarded-Encrypted: i=1; AJvYcCX5wwqySJ/8fy2b7SR+AzQr6FwLVwlNuWvLIMyB1owkixSHtxUa9B2LuJfQZgGRhpT9nvShif2LmQdwxooY4M0zZzPpyGfpdtx3A/jpuNAWlVjJEIQM9uurQSK5bo1zt93K
X-Gm-Message-State: AOJu0YzJPOa0FluREHGzTEUVtLUvEICdaoSgCaYUjU1xKMJ63NaaYw4i
	/aXDW+y8A4qNckACEaQ0JWJDHGEnA2A5EIVFPdPsXtZqzOpmNTBP
X-Google-Smtp-Source: AGHT+IEl2GFr6diHEIF4ap/P5fEdWq2f2yIGnx1lGSRUjs1iHJznSyICcqvfJ6dhUBzGvE4y9W5bLw==
X-Received: by 2002:a05:622a:514d:b0:44f:f06a:d6f5 with SMTP id d75a77b69052e-451d426d4fdmr8737281cf.36.1723088327545;
        Wed, 07 Aug 2024 20:38:47 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c87da6f7sm9642251cf.70.2024.08.07.20.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 20:38:47 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 509AB1200066;
	Wed,  7 Aug 2024 23:38:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 07 Aug 2024 23:38:46 -0400
X-ME-Sender: <xms:xj20Zhqhyhya3HEhsaxTxly-RylHcMPzC_wZq-nxqRGHLZ4Ja09C2A>
    <xme:xj20ZjoQ8qbPYkySX8d1yUtNcFRVgG3oBTiGZV7htrqyU2iXHSDbnvE6moxgsRD7b
    xEXsMfNFFtpJ8vsSA>
X-ME-Received: <xmr:xj20ZuNcfciZhdqWBXHSZArCBl2V0jK2a5nLLiKEanECAvnLFAJf9Y3Bu5ftgG34trZKIdUTt7lhBzSfaI1e6DcYsbI1SZBT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledugdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuf
    fkgggtugesthdtredttddtvdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhu
    nhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeeltdefueegfe
    fhuedtheefvdelhfeftedvhfdtveelueegtdejjedvieettedugfenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidq
    ieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilh
    drtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedugedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpd
    hrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghpthhtohepfihilhhl
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhnghhmrghnsehrvgguhhgrthdrtg
    homhdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphht
    thhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehprghulhhm
    tghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:xj20Zs7q-77QXzSJJpsFXsMx8ahtn7H0lThi13m8PkeTXNGDHkQhsQ>
    <xmx:xj20Zg7SY_zCFBwrQfwI9oNYAcCUtysZf0As8c_6RAosMO24CwuJAA>
    <xmx:xj20ZkigB29pHt8QKjq-eN9QNntC9W92B-TDGnQ_C5ukpcF5MO4GsA>
    <xmx:xj20Zi6APcVWteL_n4dDR5hcDGrbNTgu3Y-rMRbWJEtFgOLk5U5EiA>
    <xmx:xj20ZnK0cVO2GFMerVwuE68f-I7CQf2coChehrexfiCLJzA4kCG2RoRl>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Aug 2024 23:38:45 -0400 (EDT)
Date: Wed, 7 Aug 2024 20:39:25 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: peterz@infradead.org, mingo@redhat.com
Cc: will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
	linux-kernel@vger.kernel.org, tglx@linutronix.de,
	paulmck@kernel.org, frederic@kernel.org, josh@joshtriplett.org,
	neeraj.iitr10@gmail.com, urezki@gmail.com, rcu@vger.kernel.org
Subject: [GIT PULL] LOCKDEP changes for v6.12
Message-ID: <ZrQ97Zz27Tzmr0Zi@tardis>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Peter & Ingo,

Per discussion:

	https://lore.kernel.org/lkml/20240802151619.GN39708@noisy.programming.kicks-ass.net/

I'm sending a PR with some lockdep changes to tip.


The following changes since commit d5934e76316e84eced836b6b2bafae1837d1cd58:

  cleanup: Add usage and style documentation (2024-08-05 16:54:41 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux tags/lockdep-for-tip.20240806

for you to fetch changes up to 39dea484e2bb9066abbc01e2c5e03b6917b0b775:

  locking/lockdep: Simplify character output in seq_line() (2024-08-06 10:46:43 -0700)


I've reviewed and tested these changes from my end, but since I don't
have a branch tracked by linux-next, so that part of testing is missing.
It does pass the 0day build test though.

RCU is Cced since I believe patch:

      lockdep: fix deadlock issue between lockdep and rcu

is also queued in the upcoming RCU PR for v6.12. However, since it's a
bug fix in lockdep, I feel it makes more sense to go via tip. Worst
case, git merge will eventually find the duplicate commit, so not a
problem.

I'm doing this "sub-maintenance" via a PR, but I'm also OK to send them
as patch series, whatever makes your life easier. ;-) Also since this is
a sub-maintenance, I plan to stop pusing anything new after -rc2 for a
particular release (i.e. anything new after -rc3 will be in a PR from me
in the later release), mostly due to lockdep shouldn't have anything
urgent (famous last words though), and give you guys more time to
prepare the PRs from the tip tree, but again I'm open to any suggestion
as well.


----------------------------------------------------------------
Lockdep changes for v6.12:

- Fixes a deadlock in lockdep by avoiding calling rcu with the graph
  lock held.
- Uses str_plural() to fix Coccinelle warning.
- Uses seq_putc() instead of seq_printf() to print a single character in
  lockdep proc file.


Regards,
Boqun

----------------------------------------------------------------
Markus Elfring (1):
      locking/lockdep: Simplify character output in seq_line()

Thorsten Blum (1):
      lockdep: Use str_plural() to fix Coccinelle warning

Zhiguo Niu (1):
      lockdep: fix deadlock issue between lockdep and rcu

 kernel/locking/lockdep.c      | 50 ++++++++++++++++++++++++++++---------------
 kernel/locking/lockdep_proc.c |  2 +-
 2 files changed, 34 insertions(+), 18 deletions(-)
