Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C09E1E502;
	Thu,  7 Nov 2024 14:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730988932; cv=none; b=prMrYdZ1gc1zMELxB85Ufsr7v3XnuO0PSAkQnJEsC931iKZO3cNZ+o/VwG3ZTYUOee4leFBiJcqjc5Xd1qRFYI+x7aPUSYOpKLSJWxUoQAfN+6kRGhlJg1EPvc7/mTDmaTSkfyuIOAA/0XmBTCtbcZcJXLkZqSr/WkFks6N/xvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730988932; c=relaxed/simple;
	bh=e/UXU//6GQyRzQ5vrZtrL/i40sla9aShEMJ3K9+xBGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcLuO/BiZ3Xyaf5FedULJJufbCA/NpEhy4hlbG6keGrPpuBdHvod9ayDM8S8JFo3i2QadVjbeumIGuE3ViHqayBjaQ/BoWEoaOqhRSKaDCbNeddIhLmeFv23lJZqZ4XQP6b4MvzZg7TTorIgxRxF9ShFO94bJlg2AMg8/j9yhnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nweu9iXo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nweu9iXo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F52C4CECC;
	Thu,  7 Nov 2024 14:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730988932;
	bh=e/UXU//6GQyRzQ5vrZtrL/i40sla9aShEMJ3K9+xBGg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=nweu9iXoRkvx2nexRF5uZl9PSRjdS/G4WesndRAhsBlpvJpoisBP1t3FFbQ3XVDc3
	 psKhdPfinaPCSmNWMXfxPTrORKyFQTqy3mvKGn7S73wZGs2Ekj9ZyuqHnRqjoatOwN
	 jpfa4pE/AbXX/c/Ctk6qKoz9Lj0a5uJ8RenQjp3AZYwYTsgJ8fCqYrXIN3JTCZQK0Y
	 HOzh7FzZu/QC/Huy0OCHmOnLOt4iDyo8uUxMeti0T1efASfUWnzaYH0vWSN5T1ExqL
	 r2qES6/wBniCS6ycjljSRWQ/6AAcfpt4Y1pBzhOk2g3oeWdM+eOqDCNMts9RGU3hUt
	 WoWe+5R4PQwhg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 77F2ACE09F6; Thu,  7 Nov 2024 06:15:31 -0800 (PST)
Date: Thu, 7 Nov 2024 06:15:31 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zilin Guan <zilinguan811@gmail.com>
Cc: boqun.feng@gmail.com, frederic@kernel.org, jiangshanlai@gmail.com,
	joel@joelfernandes.org, josh@joshtriplett.org,
	linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	neeraj.upadhyay@kernel.org, qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org, rostedt@goodmis.org, urezki@gmail.com,
	xujianhao01@gmail.com
Subject: Re: [PATCH] rcu: Use READ_ONCE() for rdp->gpwrap access in
 __note_gp_changes()
Message-ID: <a653ce24-8dba-4a17-a3ce-68b49c99dc8d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <65bfe6b1-3bfa-469d-aada-8e79d1101d5d@paulmck-laptop>
 <20241107140117.3790954-1-zilinguan811@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107140117.3790954-1-zilinguan811@gmail.com>

On Thu, Nov 07, 2024 at 02:01:17PM +0000, Zilin Guan wrote:
> On Wed, Nov 06, 2024 at 12:18:25PM -0800, Paul E. McKenney wrote:
> > Good eyes!!!
> > 
> > But did you find this with KCSAN, or by visual inspection?
> > 
> > The reason that I ask is that the __note_gp_changes() should be
> > invoked with the leaf rnp->lock held, which should exclude writes to
> > the rdp->gpwrap fields for all CPUs corresponding to that leaf rcu_node
> > structure.
> > 
> > Note the raw_lockdep_assert_held_rcu_node(rnp) call at the beginning of
> > this function.
> > 
> > So I believe that the proper fix is to *remove* READ_ONCE() from accesses
> > to rdp->gpwrap in this function.
> > 
> > Or am I missing something here?
> > 
> >                                                         Thanx, Paul
> 
> I found this by visual inspection.

Good eyes!  ;-)

> When reviewing the function __note_gp_changes(), I noticed that other 
> accesses to rdp->gpwrap are protected with either READ_ONCE() or 
> WRITE_ONCE(), which led me to suspect a potential data race at line 1305.
> 
> However, I am not certain whether holding rnp->lock protects access to 
> rdp->gpwrap in this case. If it indeed ensures that no concurrent writes
> can occur, then I agree that the correct approach would be to remove 
> READ_ONCE() from those accesses.

One way to check this is via inspection of all the updates to the
->gpwrap field.

Another approach is to run KCSAN, for example, from the top-level
directory of the Linux-kernel source tree on a system with qemu/KVM
enabled:

	tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 30m --configs "4*TREE03" --kconfigs "CONFIG_NR_CPUS=4" --kcsan --trust-make

This particular command is set up for my 16-CPU laptop.  You can of
course adjust the "4*" and the "=4" to match your hardware.  For example,
on a 64-CPU system you might instead do this:

	tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 30m --configs "8*TREE03" --kconfigs "CONFIG_NR_CPUS=8" --kcsan --trust-make

Please see Documentation/dev-tools/kcsan.rst for information on how
to interpret KCSAN reports.

This will find false positives in the non-RCU portions of the kernel,
so you should look for reports involving __note_gp_changes() and/or
its callers (inlining and all that).

So why not try it?  ;-)

							Thanx, Paul
