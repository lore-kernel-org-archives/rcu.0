Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E61F1DED63;
	Sat, 25 Jan 2025 22:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737842803; cv=none; b=RRywSV6QyNRKjEpF3Zm0aFOV+nsL6ftstoDeMefhJFNsqAYVibhGIk9KPXQC5ercTf9o1FO5POcgnwkrYNn1cf0peqmfCGEycitRnSVVnp/aejeUfRdlB3KEWO+JE+hWYXjC/+f53AnMOuJfaPLZDo8ZtyG5xGcJfA8Qzs12Xj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737842803; c=relaxed/simple;
	bh=gRjxmpawnGrJ0LbU3iUWzmTtjikv5udNHgm2WavYJ0w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VsMTyiZj/3NKqKM4dRGhPdtjwzJ3DrJBEzR7Fn/PPV52YUy1Xr0VXo1JsnjkuZzUPkhHf7ObpKFyAUfTASoseRUKBDHvcHNqritVOgOh75BJryy/tGjlPkrYnT9zCFq8g2dhztxShKHW2O+Qg2/U/dF5cUO85k8DyXQsL9CfDJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id C003C92009C; Sat, 25 Jan 2025 23:06:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id B16F592009B;
	Sat, 25 Jan 2025 22:06:38 +0000 (GMT)
Date: Sat, 25 Jan 2025 22:06:38 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Ivan Kokshaysky <ink@unseen.parts>
cc: Magnus Lindholm <linmag7@gmail.com>, 
    "Paul E. McKenney" <paulmck@kernel.org>, Michael Cree <mcree@orcon.net.nz>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    rcu@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
In-Reply-To: <Z5U__sztq2P2UKWk@minute>
Message-ID: <alpine.DEB.2.21.2501252129060.27203@angie.orcam.me.uk>
References: <Z4-jgMJgbVriLaCr@minute> <Z5KMHoA7GlHJyUU_@minute> <alpine.DEB.2.21.2501232306270.27203@angie.orcam.me.uk> <Z5NxuIFsMUvqWUtC@minute> <CA+=Fv5QmSkP4Ysp1zHNmUPftXYbSquTCsO_o3Rcgi2T5RcPj5A@mail.gmail.com> <Z5UAFAD6xCSpKJYw@minute>
 <alpine.DEB.2.21.2501251543460.27203@angie.orcam.me.uk> <Z5Uit9F7xF0ZlMk2@minute> <alpine.DEB.2.21.2501251806280.27203@angie.orcam.me.uk> <alpine.DEB.2.21.2501251839440.27203@angie.orcam.me.uk> <Z5U__sztq2P2UKWk@minute>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 25 Jan 2025, Ivan Kokshaysky wrote:

> > >  Here just bumping up the frame size and adjusting offsets in assembly 
> > > code accordingly so as to account for the empty longword at the bottom 
> > > of the frame should do, just as I did across my change.
> > 
> >  ... or, depending on how you look at it, top of the frame and FAOD in any 
> > case the longword closest to the stack pointer will be the empty one.
> 
> Right. So if we agree on my variant, this addition patch is needed.

 Erm, that's a good starting point but offsets for the individual register 
slots need to be updated as well for `do_page_fault' and `do_entUnaUser' 
to get at the correct ones for those that are at negative indices from the 
`regs' pointer supplied, i.e. $9 at 8($sp), $10 at 16($sp), etc., and with 
0($sp) now unoccupied.  Sorry to get it through unclear after all.

  Maciej
