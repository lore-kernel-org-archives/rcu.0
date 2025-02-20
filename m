Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350B11EDA37;
	Thu, 20 Feb 2025 22:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740089088; cv=none; b=dQZ5/x6zgJJuB1QrdYX27br+k4KeMBTTipMfAuvLrU6ZQECJSBwO36wsgsIbb0/75Kvyo1gC9PiZ0pYqhc+PlTn7/qPR2ioTMPrZ5xpXqCtq2qE1unTel94oUAeaDmzrI5p4G/CGBqyvy7Nk1C9nuOOgpEzrAP885jmbU/+CK7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740089088; c=relaxed/simple;
	bh=uihc167KrdTrO3EXNbTDVRhAtMtOiSXVR0xiKhEB1uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxTg5RYjLfz4VIVKv44Mzsm0Dj5lsX/XYYA3amDeAtPOilv/PuIQn4uBR4mehRO4btsEvbeLXbUk1ZZ673w26QOfkU2IOzGQ1lHnaUdW/f58bgpns82SvBKu23/PEGowcxvE9+VzGOcF+GYyYMSySNKChs3xJaalgjkBXtaYNvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuVRn1eB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuVRn1eB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9356C4CED1;
	Thu, 20 Feb 2025 22:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740089087;
	bh=uihc167KrdTrO3EXNbTDVRhAtMtOiSXVR0xiKhEB1uk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=fuVRn1eBGFijgqaMToS+5aZSPHWQ7TDUp9r+axJ/p/g7q19AwOFCYp8zzW3FzYaHT
	 CUwZbzampzgFEkSnbHnTzkELwEwO5Lv1x20HU8S5fJSRR7zU5YX78dTCwfXfPt6o/8
	 nhiFnPUflO2/oiZFpu9WK2DgH0+WqKse2J5p9Ql/SWXQHyc1lsHMHYjrk7b4TIK3+x
	 Pr6AvKV4w5W8tepcBP1nb20YkexHatFxdH944ao1LaiUPvQr2sA0L8mywu6Mg5PvJo
	 zoe/evoGfAFgzEUVZhhuxQbNt5UF+NdlhbHDc0IaWqzO1fFsqH2bG/z79MPdyI/enp
	 +fybSXU80NO5A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 50CD4CE0B34; Thu, 20 Feb 2025 14:04:47 -0800 (PST)
Date: Thu, 20 Feb 2025 14:04:47 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Jens Axboe <axboe@kernel.dk>,
	ath12k@lists.infradead.org
Subject: Re: [PATCH rcu 1/9] rcu: Add lockdep_assert_in_rcu_read_lock() and
 friends
Message-ID: <67063387-6ba9-47fe-b283-d6346da15d9a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <657595c8-e86c-4594-a5b1-3c64a8275607@paulmck-laptop>
 <20240604222355.2370768-1-paulmck@kernel.org>
 <9130e3da-1cc5-43ea-9153-47117d57caca@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9130e3da-1cc5-43ea-9153-47117d57caca@oss.qualcomm.com>

On Thu, Feb 20, 2025 at 11:38:14AM -0800, Jeff Johnson wrote:
> On 6/4/24 15:23, Paul E. McKenney wrote:
> > There is no direct RCU counterpart to lockdep_assert_irqs_disabled()
> > and friends.  Although it is possible to construct them, it would
> > be more convenient to have the following lockdep assertions:
> > 
> > lockdep_assert_in_rcu_read_lock()
> > lockdep_assert_in_rcu_read_lock_bh()
> > lockdep_assert_in_rcu_read_lock_sched()
> > lockdep_assert_in_rcu_reader()
> > 
> > This commit therefore creates them.
> 
> I'm looking at some downstream code that is trying to become
> upstream compliant, and currently that code uses:
> 
> 	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "some message");
> 
> It seems like this would be a good use of one of these helper
> functions, but I'm shocked to see that no upstream code is using
> them yet.
> 
> Is there a reason to not use these helpers?

In cases where there is no additional useful information that can be
placed in "some message", the new helpers should be just fine.

							Thanx, Paul
