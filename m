Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DD71FDD;
	Sat, 16 Aug 2025 00:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755302910; cv=none; b=hfRYGXOBm9dIVPqXYha3drMZILoG4pjgWxP42cypvJvmwz1+XsLd4wSKXXdWJ8LgAjfZMfJVU8Fiqie/F5W+VUxfqKrqOTpGELbQhfWtRiVPcOiBcp1ZJnpyrUqIotHMl8RacXzHxJIdG9/NE/IYFFIucBHXuP/8xHDGSvDY+js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755302910; c=relaxed/simple;
	bh=7Ac/YMJKMFewz8R8eDKt44BESzppAmnzrzRfz/2R3nc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hpwJzMllL7OnK3cPXfa261qacCMeEY3h+nbaTTcAL7FzD3vObR3QYpVt5bH8uz5g0bQe6ZOEF+SSrAfw6pZdqC7OEUiVSfiV2iDS+hgQWKyB2SHVkxoUsIwK7iynuyGvbmunDl4ufF3tS4b0lcjRK45eVP8TDDzt7QosR8wjcG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqwUM+yj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqwUM+yj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B48C4CEEB;
	Sat, 16 Aug 2025 00:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755302909;
	bh=7Ac/YMJKMFewz8R8eDKt44BESzppAmnzrzRfz/2R3nc=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=BqwUM+yjfztyonaCLCTi2FEznq/2Ui7DW6I9b+vbCXBE2PvYdU0fykO8CS2d0+ceq
	 QNsVg2VnjXtaytx1cUOrh3CJAnp7DdervMEN1+MGHUX2FX3oXA+U0coON3d4zn8YZ6
	 ihjgtqv53ytf3YJ5RpoXq3kYK0a9UZo5IQ3aRogKEmakLmCAuTPFtQGnCHNihNINgk
	 Asn13Ju5DMQMqam6RjSutXEf69x6C+qKuE4KO0HCRItxZUwtKl4enH4Ss5AOlPxQgI
	 utM/u7UuYbcGxlaLBjzF/w4fMGLGPCr/utPYxBxGeOUoUTdEdpuRB0S9y/Z7y/Q57B
	 knPLV1SrpZ8Hw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E867DCE0B2D; Fri, 15 Aug 2025 17:08:28 -0700 (PDT)
Date: Fri, 15 Aug 2025 17:08:28 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH 0/7] RCU torture-test updates for v6.18
Message-ID: <8758bcc6-901f-4828-b2fc-aa9f90e85451@paulmck-laptop>
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

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/rcu/rcutorture.c                           |    3 +-
 b/kernel/torture.c                                  |    5 ++-
 b/tools/testing/selftests/rcutorture/bin/jitter.sh  |   27 +++++++++++++++++---
 b/tools/testing/selftests/rcutorture/bin/torture.sh |    1 
 kernel/rcu/rcutorture.c                             |   20 +++++++++++---
 kernel/torture.c                                    |    2 +
 6 files changed, 48 insertions(+), 10 deletions(-)
