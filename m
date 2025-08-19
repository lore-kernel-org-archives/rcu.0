Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FD51E51EA;
	Tue, 19 Aug 2025 01:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755566789; cv=none; b=Onp+Nbh8Z6UGDze96RBEQ2LVqqbDXSWUiqyG/rM1d9ry0bZOX/7VZhlGBN8Fp71KMe7bD4SH9cH11Fi7qulm//Umw6f4zxAWST4zABQugoxAz85GIhZhx1sJn86CR/Dd3/99T1QzpT46e4FQn+cr+9OJh+G6CeWGOogesk+RS7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755566789; c=relaxed/simple;
	bh=LRaCLQ18Q6kzPYjgpZThadsFFrAIt5hd5JMc+Bp70aI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HbuBoNW2tqV2cMbvqNujWQiaQtOr9OMrTB237opOhiZM5uUkYtjXyeH9k0bNbkFhCqdrnQgVrNMu33+yWJhahjCvViTbW3W1hR5DwhsDaPJfG/YO8ZvQweIVcL0wBPo42t+i/xBnpxLolAlvyT6QJXePZXQHumr8XjB9oG9Kmf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enR00Iui; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enR00Iui"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b47174b3429so3031407a12.2;
        Mon, 18 Aug 2025 18:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755566787; x=1756171587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0HxoeoNbyCC1Fpr5/MABkG5tz9PwDB+aucTsQQK+TTA=;
        b=enR00Iui4NVMDoUsn9DhrJOCV6KVENXf4JfMTwEaFf63xukkaEHPWcLSM6B/vv681w
         TNK3HCTnTB7xShuo3ESaj3+ZgSlg6vy2EGQ0salP2I8Eu7k695xMBTgd/HPc/UEpay25
         E9j4GfJiDZPgU0hg1nFsypKy1lUDE/1F4RAI/uFT+Oh2gOzrEomr6GJqLMwXvR51P2QA
         os5ewweRdT4lDd9tlRHxbopKicyj/tzKL87SIB2K3Pa3NcW+eEbK8xvUE3BU5u4+SqCW
         wepwsuzXpZHbp1qyFdfo7063neshhFmbuAfAA7LBoBSQqwuBMF3s+XXvxE0QXKx6Tru6
         hEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755566787; x=1756171587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0HxoeoNbyCC1Fpr5/MABkG5tz9PwDB+aucTsQQK+TTA=;
        b=eleqGvuJphc9Uaaq1UfJ0KCp0oq2TX8AY3LGVBjVytjZVijPazZbRhRpvFztLJTBkD
         TUG4tVWVG8SP6JhuKhryq/BuWdFI2TJ7O8v9zTpTovyAXxVFWQIi8JR4QGIwobVtWPyz
         2zcuDFhP07KBftlUJZ3HnwPAsJZIuC/9oNUYdxHnOVTXjiAFou0duHmr9iUZ2wLlM2Yh
         i/TBw36K9hMJER5spBfZ3efVAmiHP0sP1WPqddExv0kRhAlBO+JOMY6tBjwBjf1qm4+2
         2p97jL0GMW+XN9kyyXO4PM3uP5yWwQ7PD9Ox0lgcK0HclhfZdLalhzLkQStwzMhfkp83
         Yn8A==
X-Forwarded-Encrypted: i=1; AJvYcCUr1MCRP1UyrUHpaAVdNJTHDHu/nJ5XI7S22lj5aT563Pm4mSn1PcFLtNFQItyzjZuRjb9T@vger.kernel.org, AJvYcCVJy0+MTY8fj/d8c4gIm+SKkuUo67kj6PY0ex8Z59KQb3iILm5+sGNAGUSYCAy8EWYs8Q0otVhAvMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywx644OkBOxF66x6HwylpqUeWQ8epnLymZynOLBUz97qGmi/nv
	uInuFWMlixlQfMoxA6HsvtD+IMRHwi1/PVYiBEBVeO53JE3aaULVPSEq
X-Gm-Gg: ASbGncstXzb/EBsjzUzBUFCrHBt6ZRLl29P1XQnhGeOzvudQyPomNLwifNB7GExzjMw
	a9+2qR5mofquIldocEMmuJNM61YVl7x2hlkPKm4RHx8sZoG6gPTFf7hqb6OrmF8k5Pwk7us0pWg
	OKfSRc2euobUghZpzcDqlxtRtR44lzrulqjEvx1zFOvwCSgeYX6RZmXgyF97OGVooDsdDS0Uery
	e7w5fgWPMTTAnv6xDozr7eyWYyVTUfwU9a0ZGA/DNf4zSAcG5hsNRO5LgysrtZgoY9feF0Mcsz9
	5MTvlY5+SoPKU7/2J1EU6BQsRJm56xg5VhwIlpRpCXu3Io6WZ4FZfKgovn61TgRiL4IDiLe7pn1
	ttwpnTIk8db80ffkO5ptMDg==
X-Google-Smtp-Source: AGHT+IGtEm/cQazpWCcYQKgrQV+q1sHdAa7xD/XTUG9zbOQrhjLr91FtcYZGSvZtyRSk52KXEawJOw==
X-Received: by 2002:a17:902:cf0f:b0:240:2145:e526 with SMTP id d9443c01a7336-245e02d885cmr8545905ad.6.1755566787035;
        Mon, 18 Aug 2025 18:26:27 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f3c6sm92466565ad.90.2025.08.18.18.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 18:26:25 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 693CC41A38C3; Tue, 19 Aug 2025 08:26:22 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux RCU <rcu@vger.kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 0/2] RCU docs toctree cleanup
Date: Tue, 19 Aug 2025 08:26:18 +0700
Message-ID: <20250819012620.14606-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=681; i=bagasdotme@gmail.com; h=from:subject; bh=LRaCLQ18Q6kzPYjgpZThadsFFrAIt5hd5JMc+Bp70aI=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBmLLzl9Pd0xRaujP1k0dn37RgGf2dNrlpwJULILjI7eO fOX/M9JHaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZjIbTlGhvmBaX/2HJkdmxf0 l0fa6n/83Gv/AmV+VE9Iv7IqXV01J5bhv7PwMjtx7qnSqaY/lXM4vpktd8n8y/TfaV5qk9y/3zV JvAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Hi,

As the subject suggests: a small cleanup on RCU documentation toctree index.
The first patch tidying up toctree by not spoiling the full hierarchy
by means of reducing its depth. The second one edits the index title to
reflect nature of the toctree.

Enjoy!

This series is based on kvm-remote.sh wrap patch [1].

[1]: https://lore.kernel.org/linux-doc/20250819004559.11429-1-bagasdotme@gmail.com/

Bagas Sanjaya (2):
  Documentation: RCU: Reduce toctree depth
  Documentation: RCU: Retitle toctree index

 Documentation/RCU/index.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
An old man doll... just what I always wanted! - Clara

