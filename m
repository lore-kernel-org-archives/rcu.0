Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A2D3232;
	Mon, 13 Jan 2025 00:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736727583; cv=none; b=UtT9T4EKHvmVFT18cK/7BcEvL7bYADacnpQGUDTAK3Gb0TyeJTn1e2ntvy/PPPQGFyx733p9dwyjmzuU8nIRhaFhUf0LimKZqfeViOBLiza+Z/3rIFWruGOwtsFK+rKqqvUnXcELwf3rT+ZEYYtknOn/BeA5dMazUdbiaKzErjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736727583; c=relaxed/simple;
	bh=pqDmdbCiamXkau4qWurlqRzR/C3Y7KpY26jHznTpWvI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WjSC/AjZF4Htcq+rb6YL2Miv/bqUrJOeXkDzrT+dYS2iDbZ9n6Mj0xU9uSbhIKv3+LhWJ9ifaEIFrl2gjGJIwryv7/paqZRMiBSnlFIMrdUzfDP+N7ZgFX/SUmF1AyeRBIiigPqYvRz6eEPgRU2w8SGRRcH4gaeNgrgcjfs71kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id AB6D992009C; Mon, 13 Jan 2025 01:19:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id A3E3F92009B;
	Mon, 13 Jan 2025 00:19:32 +0000 (GMT)
Date: Mon, 13 Jan 2025 00:19:32 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Magnus Lindholm <linmag7@gmail.com>
cc: "Paul E. McKenney" <paulmck@kernel.org>, Michael Cree <mcree@orcon.net.nz>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    rcu@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
In-Reply-To: <CA+=Fv5TtOQkDMPnuPrPGcB0VGhUHUDqe5=Z+ovd5x5rBJ-Hsjw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2501122348510.18889@angie.orcam.me.uk>
References: <CA+=Fv5R+8y2hCq7p-xo5qZ0CyinR_0aAndUkoEAweCVs_95SMw@mail.gmail.com> <Z1YpKFQGtMWF3yy3@creeky> <CA+=Fv5Q=f-6y=EhZhG2XfZB0O=m+yOiv+gmtmMABVQZieKdwbQ@mail.gmail.com> <Z2ClSlwznfuk8Uwr@creeky> <CA+=Fv5RaqHL6MJjvhF-mn3CVY10e=2QqFBSVO6YXLUJ7WV9zGQ@mail.gmail.com>
 <CA+=Fv5RP=NoWo4VeTX7hx103=jP2d-NC-jFo+ePXLBRubCxc_w@mail.gmail.com> <ef49a479-2000-42ee-9b10-9f3b6a68ec35@paulmck-laptop> <CA+=Fv5REK+xbA49zD3aYBgG2J1Xw1FWP02qjyyOTrwbzMRXu3w@mail.gmail.com> <be4fe590-b41c-4033-91c1-94f10c4f3d40@paulmck-laptop>
 <CA+=Fv5Tk-vbAK72ZOK-bPwvnx9w_1ATH=S9t-LW8gBEgQPYa3A@mail.gmail.com> <b3cd5af3-4b8f-43bd-b3f3-c9f4644c95d4@paulmck-laptop> <alpine.DEB.2.21.2412192347450.20821@angie.orcam.me.uk> <CA+=Fv5TJhDrrxG82=MNPFEFFwKD4NDYyB1u32ZvnGv6Ma0h_Nw@mail.gmail.com>
 <alpine.DEB.2.21.2412271452100.20821@angie.orcam.me.uk> <CA+=Fv5SW-N+5KzsnVdHvy406-p+g7giUbt626xwDduy6xjaPkw@mail.gmail.com> <CA+=Fv5TtOQkDMPnuPrPGcB0VGhUHUDqe5=Z+ovd5x5rBJ-Hsjw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 13 Jan 2025, Magnus Lindholm wrote:

> I've been running some more tests, this time with a smp kernel but on
> a system with just one cpu, seems to me as a bit simpler scenario to
> analyze. I've added some print statements to smp_call_function_single,
> just to see what's really going on:
> 
> pr_warn("smp_call_function_single: %llx %llx
> size=%d\n",&csd_stack,&csd, sizeof(call_single_data_t));
> 
> output is seen below:
> smp: smp_call_function_single: fffffc000493fc40 fffffc000493fc58 size=32
> so, the csd_stack struct is 32-bytes in size but &csd - &csd_stack =
> 24. This does not make any sense?

 Given information supplied previously it does, see below.

> When requesting csd_stack to be aligned using
> __attribute__((__aligned__(x))) it seems as if the compiler does not
> leave enough room above the csd_stack struct. i.e since the exact
> location of csd_stack depends on the actual value of $sp it is not
> known at compile time. Seems like gcc does not take this into account.
> The code works fine if I remove the alignment attribute for csd_stack.
> Also as previously mentioned, declaring csd_stack as "struct
> ____cacheline_aligned_in_smp" makes it work, but judging from the
> disassembly code, this statement has no effect on the alignment of
> csd_stack, i.e csd_stack is not aligned to anything its simply just
> placed on the stack, indirectly making it just 16-byte aligned instead
> of the requested 32-byte alignment.
> 
> It seems to me that, when used to align variables that reside on the
> stack,  __attribute__((__aligned__(x))) does not work correctly with
> gcc/alpha/linux.

 I smell psABI breakage somewhere causing stack misalignment upframe.  It 
has happened before here and there.  It could genuinely be a GCC bug, but 
I suspect not.  I'd rather suspect handcoded assembly or other kind of a 
manual stack pointer assignment or adjustment made somewhere.

 Can you please retrieve the value of SP in `smp_call_function_single'?  
Just something such as:

	printk("SP: %016lx\n", __builtin_frame_address(0));

should do.  If it does show SP as unaligned, then we can dig in deeper.

  Maciej
