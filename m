Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12EF226D04;
	Thu, 18 Sep 2025 10:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191380; cv=none; b=ZUHmVZ+yVXxILixjTLVeVC9UJaz07iYdpPFATAIY1lqJOYFUsn1/AV8ZhbYuTUWRRXaDf+iurbnEHcAxukjlBIQjTho5iQCatnZAs7VIQFMgYFAdkxsEhKIKfn37b4RDlnZR63XzwdaSSN2ng+adUhsh75/lKszlqvZnCYmTbi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191380; c=relaxed/simple;
	bh=AlkVX+a/HTI+sqM2IbRhIUn6Vy6tXX7E7Jxr8FIOEqA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q+IC/DmddtXW4e8OiNeN+5d5+swbHUa92QQB8o1NCNNl0VFUQWl5lfEHN8EDxQN8mtXGmxjmuG+LsGoHJvPUCSUbULqvSqICqHMCuZVRYS8/WEm761y8/OmLoagy5t2Lf5AvLYjBLkT8oyhU69Bmakk5B4F0xuH0l3gG0HQ55fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J94LKr8u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J94LKr8u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B818C4CEE7;
	Thu, 18 Sep 2025 10:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758191379;
	bh=AlkVX+a/HTI+sqM2IbRhIUn6Vy6tXX7E7Jxr8FIOEqA=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=J94LKr8u+A+dALxJdumKx6pF1sxRiJ6/bbSu9hRQ9pdWxSplHGrd0UaaJqGzFEs8B
	 39jt6Gwrl8hFmaqQt0qYyuGSyCKyfufIVKutYfK8fVnsWaTycMpykb3IpdXgaDcGY6
	 a+Kc8/+2fjy4jA7kHZp2dVkG6yPbt45yK71tmJqTDIlU8xhqSsm6pW0XyGUXTpguhp
	 a4P3F3sE27qmmSri0MMF2xTtNB77IJeRaZyomwIDVd2w8oMXaea7YzyNdg1pxH9A/y
	 xempjtBlXamjilH/EwVQpbREIkGONkzFQ6CzvBCn+Dy+PHUjTYvZoYJn3+b4FrU0R3
	 0Q5oSnCvvKExA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DAA92CE0B32; Thu, 18 Sep 2025 03:29:38 -0700 (PDT)
Date: Thu, 18 Sep 2025 03:29:38 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH v2 0/11] RCU torture-test updates for v6.18
Message-ID: <c0edd79a-f988-432c-b08a-18793b2e15d9@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

This series contains torture-test updates for v6.18:

1.	Fix jitter.sh spin time.

2.	Add --do-normal parameter to torture.sh help text.

3.	Announce kernel boot status at torture-test startup.

4.	Suppress "Writer stall state" reports during boot.

5.	Delay rcutorture readers and writers until boot completes.

6.	Delay CPU-hotplug operations until boot completes.

7.	Delay forward-progress testing until boot completes.

8.	Use kcalloc() instead of kzalloc(), courtesy of Qianfeng Rong.

9.	Use kcalloc() instead of kzalloc(), courtesy of Qianfeng Rong.

10.	Remove redundant kfree() after torture_stop_kthread(), courtesy
	of Kaushlendra Kumar.

11.	Set reader_tasks to NULL after kfree(), courtesy of Kaushlendra
	Kumar.

Changes since v1:

o	Add patches 8-11.

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/rcu/rcutorture.c                           |    3 +-
 b/kernel/rcu/refscale.c                             |    2 -
 b/kernel/torture.c                                  |    5 ++-
 b/tools/testing/selftests/rcutorture/bin/jitter.sh  |   27 +++++++++++++++++---
 b/tools/testing/selftests/rcutorture/bin/torture.sh |    1 
 kernel/rcu/rcutorture.c                             |   24 +++++++++++++----
 kernel/rcu/refscale.c                               |    2 -
 kernel/torture.c                                    |    2 +
 8 files changed, 52 insertions(+), 14 deletions(-)
