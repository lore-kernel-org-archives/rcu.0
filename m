Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C77429CEC
	for <rcu@vger.kernel.org>; Tue, 22 Sep 2026 08:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066719; cv=none; b=a27Fy1BXeWFbAT/DQPnobjocgkbXRFonmUIEVv1QPaEEDpBSDgiChWrDKe8jro9umdfHpUAkvXee7E52hD6K6caX0vFaKmNR3MMq/qKKmml4HPu80yEhtfxvFD+RtIHPEbFMAd/eqfGB8hMTgYWo4dS1X3J0UgH6vE0qXjGc1Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066719; c=relaxed/simple;
	bh=rWOXTAtkNKBbD+uEgNV1nTyqhko/HqdFlDPSq6vVwJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BzHs0Oj0FJQcByVGOHrKRFqtI3BfopdAt1bEJzBLfyZvE5tXet7FoHxXrNqCX5huOCY/KpDPh3qMVmRHW37xRarhaZLvKql0442/yyfrQwZPYx37ww2QnwDpW7zwaploxPFNKRAKwbCij4rR6jt6hBXREG3mdxpT8297pJEJQZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDiHSjJw; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDiHSjJw"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747eefae4so12031035ad.0
        for <rcu@vger.kernel.org>; Tue, 22 Sep 2026 01:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790066717; x=1790671517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rWOXTAtkNKBbD+uEgNV1nTyqhko/HqdFlDPSq6vVwJM=;
        b=JDiHSjJwHZTGuhFG4Yb7PLcjNAdg2cPNH07nQl7euJYOZgF37nMxsEDqb4Pk+uFQMw
         fYZ6LwDyaJqqiVvkB6+WGwLq+bF6PYBNPQXuMfFZ16FcoA0HUmvBEDlWdE1jr//aK6b3
         g7xiScS9qW5E06jUIiwo8yvb7ITLPRobdIyyyCN4x9Jp4G0lKz3vbAaNSyjHC7KneFkd
         YgGwTz61AaWyGB+3fhvmdRVlcu9TWub1iZHiy+mmLovF0CVgTPRNJh3mhzBQrXQYAVDF
         aWDIK1yV2GOnovj1HQsC6SMATNU2e9BFj4tTRJeUMKXF1I/DdOgByd0ayAEblP51k1B7
         Z59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790066717; x=1790671517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rWOXTAtkNKBbD+uEgNV1nTyqhko/HqdFlDPSq6vVwJM=;
        b=wuEeXlTMrQG84u/gcnthCjX22eVBzDqikVkYFbKWRNIO17GELhO0sAdIb51cstX4Qd
         2UnTObqMjjMS/nTFMUGVMnIBvd8eKBi8itysDGmWEf6PQog8ctK4IDe+8cdPrtm/sRzM
         G8tH6yOeESpMi5PugKRpqGBQhuLaVwqAxN8AQH5trE+UCmL9E7mZZ977gtWHpfZBJpok
         zbxYNCsh1Ro6fUOiKTVR796hSrqBhKA+ppzpbyBZSys5UrF/JVFF+1Ftzhy6SOG9eT1E
         henunT7iUSqrzhr6AEET/7oGtO2B+Mnst50osMXjaBroHlcWfXxwKaFEOQDujjAJKor+
         jqDQ==
X-Forwarded-Encrypted: i=1; AKwUvBy4NkyV4sw/p2iHt+Ba8OzASYl35/B8R4rXhP26CGp2XHeGVmsxKFlC+hhrXoo7qoCbhZU=@vger.kernel.org
X-Gm-Message-State: AFuF++nQE5HYV5Y25tw4b1gRnbpUlKQ8bP0pGL5DQzuAyp8zZ0N7OTLX
	PwxLux19fCk3LcYEjf5yMEd+fW2dnaXmKECmVhfi0g53acKUmdxUM0hg
X-Gm-Gg: AYBFou3yPkmOYF+dgoHEEYP7pmFiv6q7jT3dKlXogTTNrTdeGNTYIm637RjQCeEy38v
	ObyiN2WzDZJDpdAt6LCnrQfTCxsMg7Obdf2eEX1iizxnje7yfQI5e0ET05XI7iLVTw0p7skiXPo
	2646Qdn3G0Uv5bm8OoabdjGTfdz8O1giwyYpz9hllnztpBTs1oVSkdFNooi0zaqH1g0RYSJz/ik
	8Hyj1Obl6G3zfPji4QkNX+Q2RKeCEVAR/o5uZnnuSj1koLWtANzywCMYUwMCJDhS+EQJOeHV1g0
	BEN0fgu/TkhTbL0WMYP/IEk1lffS0ATjghSP8gNAJ0NCh+IZoFVaeaWpeFXYkE2HzB5QJcGA22J
	W5vL3KLyrU5OJj+zjBfNu84+goCbgyGlbNzb4cPBd/Mqr72fOxmpHpSA1nhJPHM8CA22KF/QnPT
	+H6UufhIfGye3LswqLpVMoqROYzDPpYJBc5KIi2d4E0XHszzzVO7kQRNR6/ykgry5eq4TYvpI3f
	t6FxM9EKNC2CHLpJcowBSCzv8IVWlamBYkrTBwn
X-Received: by 2002:a17:902:e952:b0:2dd:c100:251d with SMTP id d9443c01a7336-2df60f2fd27mr3267025ad.38.1790066717422;
        Tue, 22 Sep 2026 01:45:17 -0700 (PDT)
Received: from localhost.localdomain (vmi2317699.contaboserver.net. [85.239.239.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df5d0588e9sm6100495ad.76.2026.09.22.01.44.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Sep 2026 01:45:16 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: Boqun Feng <boqun@kernel.org>
Cc: Kunwu Chan <kunwu.chan@gmail.com>,
	stern@rowland.harvard.edu,
	parri.andrea@gmail.com,
	will@kernel.org,
	peterz@infradead.org,
	npiggin@gmail.com,
	dhowells@redhat.com,
	j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr,
	paulmck@kernel.org,
	corbet@lwn.net,
	mingo@redhat.com,
	dave@stgolabs.net,
	josh@joshtriplett.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	urezki@gmail.com,
	akiyks@gmail.com,
	dlustig@nvidia.com,
	joelagnelf@nvidia.com,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	longman@redhat.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	include@grrlz.net,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	rcu@vger.kernel.org,
	lianux.mm@gmail.com
Subject: Re: [RFC/WIP PATCH 1/4] hazptr: add shared-scan kthread
Date: Tue, 22 Sep 2026 16:44:37 +0800
Message-ID: <20260922084447.58084-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <arI8KNUjYNFBwKf8@MacBook-0RXW5>
References: <20260922070950.4173245-1-kunwu.chan@gmail.com> <20260922070950.4173245-2-kunwu.chan@gmail.com> <arI8KNUjYNFBwKf8@MacBook-0RXW5>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Boqun,

Thanks for the suggestion. Kunwu and I will work together on the next
iteration of the shared-scan design, including your idea of avoiding
per-synchronize allocations with a Bloom filter. We will also run the
rcuscale comparisons and collect IPI counts for the lockdep workloads
you suggested, then share the results with the thread.

Thanks,
Lian

On Tue, 22 Sep 2026 10:28:24 +0200 Boqun Feng <boqun@kernel.org> wrote:

> This would requires allocation during hazptr_synchronize() and I would
> like to avoid that (it's going to introduce a "allocating memory to free
> memory" case).
>
> Mathieu brought up a useful data structure for the scan: A Bloom filter:
>
> Willing to give it a try?
