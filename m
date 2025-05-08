Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F870230BD0;
	Thu,  8 May 2025 23:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746747895; cv=none; b=R5oDGvmWWx7BdcbbWj48cWznwvA1XXIm1nszKMGtqodlJkmbuxS54faTs/81VgW2MRhHwCYJOGkJ1uw37QX3xI9tX/DDS88RowKYg0lqh7Iu/5lQkVLL2bjv8T7OciVljM39WZ/xlnjMvwiN57Rjl0XUYhN2edpgHgSmvqEiDiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746747895; c=relaxed/simple;
	bh=GgaaZEfwWTni/AhkB94pMqIyAWLeWgFcqf0B/7AJi7o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NdQgEydgM1/u36FToDLy4o9PxlBmFS69789x/LYfZhyYVRfxvnD+RG3Bde/Rz2x7A6RpZ3HqCgA9VolUMCcJ2W/Eace5G9zen7YiDAktbvwdndDcpMTmYP2sFDgj0nNfehNjCW+nF2qHor+kJNu0zfv9J/ljmIU/vAKZHI/zxmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cz1Waep9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cz1Waep9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8CCC4CEE7;
	Thu,  8 May 2025 23:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746747895;
	bh=GgaaZEfwWTni/AhkB94pMqIyAWLeWgFcqf0B/7AJi7o=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=cz1Waep9xCEfNgpxu+9eDZHlCe/QJ4RIqnS7SYRYwiHamS4epBGTxRTsJZYpW3Ekz
	 w4uyWSYk1XznJTbEp8Kwx4jYh8trDGMpbpCgR24Ihnnnu4vvlklEvcOzqXpFC5iWJj
	 LM/VThovpxBMZ3E/V4xFSi6a2Xyroy7sAhd10rzq7tRs6L0fwa1UatIdqWfMlfST3w
	 2Dk6+6BTe+OAJi00IyILIktYtDPfgNKhHZWfKgLiDsngp7uED/xArr/BlGG2Ukwku+
	 bVDYuhwvy7kDJqzH+rvH+Ps07UQ/vx+84TyPWQmHl+0m3E8UWi5+1Gsjp5RtYvgQaI
	 ppaOQY4iEsLqA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E7593CE11A4; Thu,  8 May 2025 16:44:54 -0700 (PDT)
Date: Thu, 8 May 2025 16:44:54 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH 0/5] Miscellaneous rcutorture updates
Message-ID: <a942066a-85cb-4932-b4de-0ee39287ab7d@paulmck-laptop>
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

This series provides miscellaneous rcutorture updates:

1.	Suppress torture.sh "Zero time" messages for disabled tests.

2.	Print number of RCU up/down readers and migrations.

3.	Check for no up/down readers at task level.

4.	Start rcu_torture_writer() after rcu_torture_reader().

5.	Print only one rtort_pipe_count splat.

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/rcu/rcutorture.c                           |   30 ++++++++++++++++----
 b/tools/testing/selftests/rcutorture/bin/torture.sh |    6 ++--
 kernel/rcu/rcutorture.c                             |   13 +++++---
 3 files changed, 36 insertions(+), 13 deletions(-)
