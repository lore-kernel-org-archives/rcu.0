Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20AA1D8E1A;
	Thu, 12 Dec 2024 18:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029553; cv=none; b=NHC7lP3OMwIGPAZZ8NZIRAtP4TRZaZj9joTAu2h1PAGzByX2VdixrcVPB5hhgwJ9GvjiXfLflTyCgwICD3l5IY28dE0GQsFGkXGeP9vZH0/svrkoPyaux3SRQKPsRnugDb+9lPaxBcY/miqngWLhpUwNPLEdz2A4dwNOpIOFOS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029553; c=relaxed/simple;
	bh=KFgi3Ve6mSeB/FSdSJW/CXJ6/cWYIAdG0yvzLfPd/pA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jMAuxAxWGZyTajOOTyW2k+GfvUoLTbxS97C6Anss4vAwC86dGWiG6GnK7ifI6LBnNQtSTrFShMa7uLb+TH2fJ74NUtkraeW1nfiY4UFh0y+fVtbEt2W2TWQOntIN598XPd3ArYRIW5CwJX/SaKN4+x4Yy0Zu7uVlb0TzazDftks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXBuFRaP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXBuFRaP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420EBC4CECE;
	Thu, 12 Dec 2024 18:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734029553;
	bh=KFgi3Ve6mSeB/FSdSJW/CXJ6/cWYIAdG0yvzLfPd/pA=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=PXBuFRaPQ29DOwpa1uCXKhC94sMEYGDyZU+MDVJz1cUbIfUdDEJ5Vye1gaGOZ64ha
	 8RGWntmV/NVReexYtOvXOBi08ZNVo9dEMTApd5Dfp1p1DC1ediQZ4myZwj1D+cLOK7
	 nTT7VHATdXyHAk2QPyNYdJIh5LOW4lEmgleiOyrNQ4qgbzRoFR7sePW5OWpa2eWcVi
	 HN62Wl2lbKLEXCWFXuRGHRvza/6fWCPRXfxbUS50BkwVqLB9m4+vf/0iTU9sd20nJX
	 HFKHDZ6Xx6XyyZewVipiECgTzR2WZXcf18JYG0Ftb7CtA0khD0Z1P8D80zx9pdcLQg
	 PZNOZQYRHYxJw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id F2B4FCE0F53; Thu, 12 Dec 2024 10:52:32 -0800 (PST)
Date: Thu, 12 Dec 2024 10:52:32 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH rcu 0/2] Torture-test updates for v6.14
Message-ID: <f9bb99e2-4369-4ff1-9ec7-4a403a0f496e@paulmck-laptop>
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

This series provides a couple of torture-test updates.

1.	Add test for sched_clock().

2.	Make kvm-remote.sh give up on unresponsive system.

						Thanx, Paul

------------------------------------------------------------------------

 kernel/rcu/refscale.c                                |   40 +++++++++++++++++--
 tools/testing/selftests/rcutorture/bin/kvm-remote.sh |   25 +++++++++--
 2 files changed, 58 insertions(+), 7 deletions(-)
