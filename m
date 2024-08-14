Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517A01B9B5C
	for <rcu@vger.kernel.org>; Wed, 14 Aug 2024 16:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723653133; cv=none; b=lQvnLdb9h+Y2vGLyKJRsAMJWQDWnuaWzHmO4/g9g3mwyBxUOGVum9FvntxDdV9zi6WiestonV7UeizrGLcvwZmOQLQ3GF1Q6arSNFUnEABAUn7RTrfKhKiA3DLJ9TSMg9F5x6e3bbACNg362jT6M93u5chXiWdeu/pQC1RVukik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723653133; c=relaxed/simple;
	bh=kSVdfFwJQfh4RpCUaQZVr+6SklanaKIsGpwXLwV9PKA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iIf3tb/mbr5CpLHu/4Gh684ovuLARSeNml0EaTjmoApcFqro1eSDlFEyhX45ayC/5JE5XEYXH9AGez6BVG5KscpPVdkE4O08fNExnuF6wqWuCsZnto22ywgIh/D1cUowwdztx+heINT7E2F5WEYrRXCKPt/YOG3t97SsfPiLb84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGcHbuCm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGcHbuCm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABFE2C4AF09;
	Wed, 14 Aug 2024 16:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723653132;
	bh=kSVdfFwJQfh4RpCUaQZVr+6SklanaKIsGpwXLwV9PKA=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=CGcHbuCmAW5BpUIAM98LN6EhYa4HQJGwtG6Buw7CdoiWcZ2uPMAHPdoWATMGqocIN
	 cHIu4WKX2RrtFk/1s7eEcsz0JKsDuQ3fs/wuvjjU77r/k0x3orJ8yb00wVrj3Z+pd/
	 EGlzyPmKWSCakpGW4eNi1QG1bA0m6d8XFmhU24XpZLrvJS+PcqopKwlWmagR2UA/Rn
	 fxuL8Wwh9aJ1wrW2B0jCEkQBqV8y1osJCxFYozwYRZ7O5CMTIaFa0tH/wiNIknJ8sM
	 wNnmxLefWgDBR62imtr+1MzMLHIcvDJlecfwkTB0Tk/8XJZzHrfmE3lA+6k1l2QAVv
	 nwp/S4wchmVlQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 49EA0CE0ACD; Wed, 14 Aug 2024 09:32:12 -0700 (PDT)
Date: Wed, 14 Aug 2024 09:32:12 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: torvalds@linux-foundation.org
Cc: neeraj.iitr10@gmail.com, frederic@kernel.org, rcu@vger.kernel.org
Subject: Neeraj Upadhyay will do v6.12 RCU pull request, Frederic Weisbecker
 v6.13
Message-ID: <08c365a6-e382-4a0c-b1c6-89e57b87f6de@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello, Linus,

Just to let you know that Neeraj Upadhyay will be sending you the RCU
pull request for the v6.12 merge window.  This is his second time,
but the difference is that this time he is also "curating" RCU patches,
that is, pulling them in from the mailing lists, doing initial testing,
and working out which go into the v6.12 RCU pull request.

Frederic Weisbecker will be doing this for the v6.13 merge window.

Please let us know if you have any questions or concerns.

							Thanx, Paul
