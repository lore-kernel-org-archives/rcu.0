Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BA1146596;
	Fri, 24 Jan 2025 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737730583; cv=none; b=N7pKNCx1ikoOWjPof8SEWlbwk0WuMFIfw800aLFqTD6GoNG2Ua2i9x6lQzRZiV9REysuuelqk+SgkHRTBFte7fkmlfVcWMyKouPwBwmhEP61pervDdQC3eLW2mvmOr/DKjODzAFc7Un6UImI5y217HIoCLKfvlsFttOISvElBww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737730583; c=relaxed/simple;
	bh=oxik95iMeWZ8ZQgMWf34sjCyLsfuchERTcGyQmex7aU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4ZgmZ0PLXQ0Y6G9TcGdk2rkZHj6aK05M2zOf/b5R/N3szLN6MCT/OKuUQBDUXj1JH5b5/cwu7VVo0/ePfi9Qw3gazzpY7cXvp64mLcj/e1Z8saVCJjxTeXAjnjXQch5PdDmD8OveGctUc/2eY8Zjwe6zGcloKNbp2Haofu2Gws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEVl04C7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEVl04C7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13CDC4CEDD;
	Fri, 24 Jan 2025 14:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737730582;
	bh=oxik95iMeWZ8ZQgMWf34sjCyLsfuchERTcGyQmex7aU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VEVl04C7vxv4wilrX0xnWwxSsjhoPo04IBnHo24YQNdA8bb25GM+vEAY9NoG8jbYr
	 5PT55Pqw37k8gxKuQAqctV6PERfo7O7fjx3Rpi7pcOZHs9c7CJC9nXENfxr39GeJ3/
	 VBrfFY5U3LelFOx4KYD37Gb/UNpQvzismxAqI9iL17KspTiKB/0PoCc/ylJ7s9/W6g
	 ahWuizzgS+u7pYdDH6sC3x9AVArvt8x1okjrvhN1pe4fmQBZJPwUy+IJZ150pfJ4Sw
	 mc/n6zDibuwErB8qi8dljs5yqbx3D9CHrd7ASzrg+bJSIi0x/mPsjdafZwxdIbctgH
	 TT8TbeAVZtkhA==
Date: Fri, 24 Jan 2025 15:56:19 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: paulmck@kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, rostedt@goodmis.org
Subject: Re: [PATCH RFC rcu] Fix get_state_synchronize_rcu_full() GP-start
 detection
Message-ID: <Z5OqE-eJDo-1W_-r@localhost.localdomain>
References: <eb83ab84-05b3-43da-bc59-e2dbd932740c@paulmck-laptop>
 <CAEXW_YSo1NTmx8FE3WNN7zL9so24o40HXhxubHJVvfxWBYtz0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YSo1NTmx8FE3WNN7zL9so24o40HXhxubHJVvfxWBYtz0w@mail.gmail.com>

Le Thu, Jan 23, 2025 at 08:49:47PM -0500, Joel Fernandes a écrit :
> On Thu, Dec 12, 2024 at 7:59 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > The get_state_synchronize_rcu_full() and poll_state_synchronize_rcu_full()
> > functions use the root rcu_node structure's ->gp_seq field to detect
> > the beginnings and ends of grace periods, respectively.  This choice is
> > necessary for the poll_state_synchronize_rcu_full() function because
> > (give or take counter wrap), the following sequence is guaranteed not
> > to trigger:
> >
> >         get_state_synchronize_rcu_full(&rgos);
> >         synchronize_rcu();
> >         WARN_ON_ONCE(!poll_state_synchronize_rcu_full(&rgos));
> >
> > The RCU callbacks that awaken synchronize_rcu() instances are
> > guaranteed not to be invoked before the root rcu_node structure's
> > ->gp_seq field is updated to indicate the end of the grace period.
> > However, these callbacks might start being invoked immediately
> > thereafter, in particular, before rcu_state.gp_seq has been updated.
> > Therefore, poll_state_synchronize_rcu_full() must refer to the
> > root rcu_node structure's ->gp_seq field.  Because this field is
> > updated under this structure's ->lock, any code following a call to
> > poll_state_synchronize_rcu_full() will be fully ordered after the
> > full grace-period computation, as is required by RCU's memory-ordering
> > semantics.
> >
> > By symmetry, the get_state_synchronize_rcu_full() function should also
> > use this same root rcu_node structure's ->gp_seq field.  But it turns out
> > that symmetry is profoundly (though extremely infrequently) destructive
> > in this case.  To see this, consider the following sequence of events:
> >
> > 1.      CPU 0 starts a new grace period, and updates rcu_state.gp_seq
> >         accordingly.

I don't think so because idle CPUs are waited upon to report a QS, unlike
offline CPUs that don't appear in ->qsmaskinitnext.

If the CPU 1 is idle while the grace period kthread scans its
ct_rcu_watching_cpu(), then the QS is reported on its behalf and when CPU 1
goes out of idle it is guaranteed to see the new started GP on the root node.

If the CPU 1 is not idle while the grace period kthread scans its
ct_rcu_watching_cpu(), then CPU 1 must report a QS and that cancels the race.

Thanks.
