Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888DB80B;
	Wed,  2 Apr 2025 06:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743574572; cv=none; b=C3wCd6xShOVAawZnhKD2+8s0ndSO9ZnfJ6Q7KADyNV1Oka85d0iYYBmFCYIwTZUrTP87PQxa3SglKjXmE2wizRY6x2vrLiKC6nCgiEgKMgKwNgVWl2R1on5rH1ATrfXxsRe5GoFtxqTlNfeV/TGOIPwlYApO43/RI2pWSUou8LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743574572; c=relaxed/simple;
	bh=vmpu4YC/PRRs8XjKklT2RrrZis8SeTawy4PuKhF9wXk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=P1lVZvFvUUO8FTX9+gV1dKnk/zuEXFz9QetRII7cKIn/9WRf13ng+U1i+uudduJTOqDdopoVids3yizCdhz1rutIL4pAtnkXsp8mzIuWYx7cEfboK4HCmpx+fyH5Na1ccEVM50xmHZNEzouCGEQKHmYjzSDlBhAZu7EPnCEeAY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnRL8P10; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnRL8P10"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-476a720e806so57902091cf.0;
        Tue, 01 Apr 2025 23:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743574569; x=1744179369; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oWeV1Up5IHODOE4k77zE9/I9u8COZf4WDlelmbAetLQ=;
        b=MnRL8P10p/tcZoSYKujqsFSUKq0EoO3xxWAgVExUuMEJ32g2BGdUi6jUJF1kL0X2+v
         wRoczi6fp85SZFwk/joTb3BRyPcdkH3Jb6fFmgKCr9rqM4gDZYUPbRrQCcDAKhUqXtq7
         UqivBcyOYPqJgSUZ7XKxbjmorN2fky7sciR6hEzOlshRCCz1dSyxf3WzB4rF3O5f/hnv
         8lBE1irMRkiPA7/JKXUWXMypGgcMHQJCASeRfxM76uXrZblqfPOzsHowRm45rxryoykT
         FuL+7WS9naVfiV4P07zJ5hLrjjmgTqMzDzI5hQtDaYFxzvmNZomAoag2X/7Lk9Bu4c1T
         HOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743574569; x=1744179369;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oWeV1Up5IHODOE4k77zE9/I9u8COZf4WDlelmbAetLQ=;
        b=ADAU2Xiushjg3cwsyAqBltT6o11nBoIpvHxA4SjkCkCr4lzbD/oTdtAUrE5xCjTqJm
         7l6ohGAiu4owOPRLtpwu+afBSf2vOI3kMYHHgINWnuoLb23Is/UID1dHq0qdx8s528/d
         Q5HaZSth28g3Z1kPcOJwYtKotJYtEqb9itg5r/Y1b5r8dH78FWczOzC99Dy7igkpDZ7m
         IKrj7aYEwwgTe813behGXpXV+G+P403ITryo3+9XW0KoDdbXaSeQ5RUhe2g0RwAFpPAj
         m2g+2EFuDHBy+X99Du2o0y+q3lB4JNBbx3K02mwOq5iLD0kxbeha2AHNbIlznbnsUpU3
         XkSg==
X-Forwarded-Encrypted: i=1; AJvYcCU/F4KmqH3pU/rW0H83jD7KFIrQU6J8GrDr9UQ9rP4eOB/8CFCAulBM9Mq73WtO3fhNqGsr@vger.kernel.org, AJvYcCWit9IQZ9+3iplgN5XIw9LCbrlC/9xjNqYKzhf0dU0oHlxJEKh51MF2Qywdzm7tHyQgsjF0JcSzjVzOzUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS6qutSUbbBM2M/EV8n9e4wsMmvRJ2hVwu51d6sdsfJgV8m+cn
	h1eTlj45gv7+nYxZcwPSrDiTup1VqXTjp5ELu+msanXRdgXW9K7UmME7kA==
X-Gm-Gg: ASbGncuDrYEkcWUr1bxTn9fdup9LBMA2PbxYnrt6VSgwNhdUNp4KnJmTjsmg2xX3xz5
	VbDC7xlQGN5jJHkrhRBHegRZzlarZ8KrBnZ/FmHDWotIc2eUKFRFTY3ffPYsrWKcG7Z8PIDNQfW
	Gicu7y+uPmgsRmyAZYiHW7CA8QwwxNh40FP1r1XecO8JfDXVu00Dqmh6p9WTKriHyjqsKXBG0T2
	jwUXBRobP8mPbrjgxN8l6gtThSnaPBqgEGZiGC06I8vQPPJenVeeNkZrApWUbqGcTYeJbD20/gP
	DhRd3s3sqrl3dJDWbYUKCq/+3frgnkPAVQeV5zM+LmrILgZR4e4eROUuLFpl81KhLjcDAuGevrp
	Hf5ImDYV+LSfgYWAR1aeM9J4VfL6DU16cKlY=
X-Google-Smtp-Source: AGHT+IFfBlGV2OpbdIp1rvFX47H+BCvhk5WFFr2TddE/4pLcesD7z/zphEzY3GW+7e7iKg9jz/k4rg==
X-Received: by 2002:a05:6214:ca2:b0:6e8:fb8c:e6dd with SMTP id 6a1803df08f44-6eef5d677e7mr87688146d6.5.1743574569281;
        Tue, 01 Apr 2025 23:16:09 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eec9627d72sm70986366d6.10.2025.04.01.23.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 23:16:08 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 37DF01200043;
	Wed,  2 Apr 2025 02:16:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 02 Apr 2025 02:16:08 -0400
X-ME-Sender: <xms:KNbsZ-vrFZUHLx1JilYrws3hZ_iicLf42tkkQf1vqYiBYHyprGrKBQ>
    <xme:KNbsZzex5Lqdg0kj6gMoxwhDuXvmLVIV790BMLxI04WATqHrldpZUyFkOiSA6h6sF
    _gXgubCpp8UFVsVTg>
X-ME-Received: <xmr:KNbsZ5w2qxLpV-JmoGPET1TH1oDJ17BB42j7RWlIU7zqIoZCFDPEfPMM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeegleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkgggtugesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeeltdefueegfefhuedtheefvdelhfeftedvhfdt
    veelueegtdejjedvieettedugfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epthhorhhvrghlughssehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphht
    thhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehfrhgvuggvrh
    hitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvvghrrghjrdhuphgrughhhigr
    hieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhovghlsehjohgvlhhfvghrnhgrnh
    guvghsrdhorhhgpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepuhhrvgiikhhisehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinh
    hugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgt
    uhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:KNbsZ5PUqariRKwuwsgBckuXs5gobYCoD0NCVNaMLk6vK-acXMxW8A>
    <xmx:KNbsZ-9YE-0GGe0kDMzwQzq7Am8upnh-p4evRYd3PQC2H0KxDs9sWw>
    <xmx:KNbsZxU0XhKa0uSe6-Vs37B7E8ENNfSTEHTnKhHz0XUzAJSwtxaLQQ>
    <xmx:KNbsZ3ec4CDZjozS1qIuG_GHW5Y425vYqEJVooHMq5b2M-j35BwSxA>
    <xmx:KNbsZ4dVmkS4EP8IornaTiC4RJU0LKWytRR_PC8a8UFvPBDbK3y7iPZa>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 02:16:07 -0400 (EDT)
Date: Tue, 1 Apr 2025 23:16:06 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] RCU fixes for v6.15
Message-ID: <Z-zWJj-pYdvuUYPE@Mac.home>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull the following RCU fixes:

The following changes since commit 467c890f2d1ad6de9fd1dbd196fdc8f3ee63190a:

  Merge branches 'docs.2025.02.04a', 'lazypreempt.2025.03.04a', 'misc.2025.03.04a', 'srcu.2025.02.05a' and 'torture.2025.02.05a' (2025-03-04 18:47:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu-fixes-v6.15

for you to fetch changes up to 1dc1e0b9d694eb9016d3105ca4ba8bd90eba888a:

  srcu: Make FORCE_NEED_SRCU_NMI_SAFE depend on RCU_EXPERT (2025-03-28 21:19:17 -0700)

----------------------------------------------------------------
RCU fixes for v6.15:

- srcu: Make FORCE_NEED_SRCU_NMI_SAFE depend on RCU_EXPERT


Regards,
Boqun

----------------------------------------------------------------
Paul E. McKenney (1):
      srcu: Make FORCE_NEED_SRCU_NMI_SAFE depend on RCU_EXPERT

 kernel/rcu/Kconfig | 2 ++
 1 file changed, 2 insertions(+)
