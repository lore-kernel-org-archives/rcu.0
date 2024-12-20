Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EDEEC4;
	Fri, 20 Dec 2024 00:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734653250; cv=none; b=smW7bKbYgj2yMGvvxyq86OCMFaNtbC/wIEx2cOyDkdgma82lySqDlJn1TvZu4ddF35shNaDLinBtV6QRDCs0fJUdduw/tjhwHfG9g6fkRTPycty4uQe9nvBc5X1bGpI3//7tNDNMGgz5WzZRY/DKraFKrdKna4pqWg2ulM7B2jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734653250; c=relaxed/simple;
	bh=f0jPiFB/7f93zzc1imVJ56uE9ZKmnzWn2X5fX3kLDzc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=prR/SnNIkictA8+Mf5vb0HT404WEJqzWjynkzuRxM1cTVnrQwdoWfe+QhtPtpwUdHN8c6wqCmV4uli/9bd6tj9KOs/1I8WEsX53LIZ5/TjKhnyTOeCvwR+FGhe0zCWdcCjE/2ShRyAL82YpuUSo9fKtrWziZB4maThhU6H8AWZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id C9AD392009C; Fri, 20 Dec 2024 01:00:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id C512792009B;
	Fri, 20 Dec 2024 00:00:13 +0000 (GMT)
Date: Fri, 20 Dec 2024 00:00:13 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: "Paul E. McKenney" <paulmck@kernel.org>, 
    Magnus Lindholm <linmag7@gmail.com>
cc: Michael Cree <mcree@orcon.net.nz>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    rcu@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
In-Reply-To: <b3cd5af3-4b8f-43bd-b3f3-c9f4644c95d4@paulmck-laptop>
Message-ID: <alpine.DEB.2.21.2412192347450.20821@angie.orcam.me.uk>
References: <CA+=Fv5R+8y2hCq7p-xo5qZ0CyinR_0aAndUkoEAweCVs_95SMw@mail.gmail.com> <Z1YpKFQGtMWF3yy3@creeky> <CA+=Fv5Q=f-6y=EhZhG2XfZB0O=m+yOiv+gmtmMABVQZieKdwbQ@mail.gmail.com> <Z2ClSlwznfuk8Uwr@creeky> <CA+=Fv5RaqHL6MJjvhF-mn3CVY10e=2QqFBSVO6YXLUJ7WV9zGQ@mail.gmail.com>
 <CA+=Fv5RP=NoWo4VeTX7hx103=jP2d-NC-jFo+ePXLBRubCxc_w@mail.gmail.com> <ef49a479-2000-42ee-9b10-9f3b6a68ec35@paulmck-laptop> <CA+=Fv5REK+xbA49zD3aYBgG2J1Xw1FWP02qjyyOTrwbzMRXu3w@mail.gmail.com> <be4fe590-b41c-4033-91c1-94f10c4f3d40@paulmck-laptop>
 <CA+=Fv5Tk-vbAK72ZOK-bPwvnx9w_1ATH=S9t-LW8gBEgQPYa3A@mail.gmail.com> <b3cd5af3-4b8f-43bd-b3f3-c9f4644c95d4@paulmck-laptop>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 19 Dec 2024, Paul E. McKenney wrote:

> > Making just these (see below) one-liner changes to tree_exp.h and
> > smp.c respectively, lets me boot kernel 6.12.5 on alpha without
> > passing any special rcu parameters to the kernel and it also lets me
> > load/unload my scsi kernel module. Is the alignment of structs just
> > giving gcc more room to clobber the stack without actually hitting
> > anything important or is it relevant for how kernel threads access
> > structs on weak memory-model architectures?
> 
> This looks like the aforementioned bug in Alpha's compilers, namely
> failing to comply with C11's restrictions against compiler-induced
> data races.  I can't say that I am at all excited about accepting these
> changes because they increase stack size.
> 
> The best thing would of course be to fix the compiler.  If that cannot
> be done, why not just carry these patches?

 Right.  Magnus, has your kernel been built with compiler options implying 
BWX support?  If not, can you please rebuild it accordingly and see if it 
changes anything?

 Also a data race between RMW accesses can't be ruled out even with BWX 
Alphas, because GCC insists on producing those sequences, as I discovered 
in the course of implementing said GCC fix for data safety[1].  For BWX 
use it should be ready to build a working kernel right away, because no 
unaligned LL/SC emulation is required, so Magnus, can you please try the 
patchset out in the second step and see if it makes any change?

 Of course it might break things horribly too, as I still haven't got to
verifying the BWX side beyond the assembly pattern match snippets in the 
GCC testsuite (to be done hopefully in the next couple of weeks).

References:

[1] "Fix data races with sub-longword accesses on Alpha",
    <https://inbox.sourceware.org/gcc-patches/alpine.DEB.2.21.2411141652300.9262@angie.orcam.me.uk/>

  Maciej
