Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFC71D5ABF;
	Wed,  2 Apr 2025 03:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743565732; cv=none; b=OGTlPQJj77XyfVrcHQJRCYq6VdwRwxX4dZflQJq985EnDrviKzkZi+nKzcaKKc59IY1F4yk7cNOHeXsV8nmsjOIHW2iIAnm/VZ2Tu+Q6Br4mXRrhhZNPvNKFD03Oeogjn6hTK/OFBwgJWHmiz0txgQvi1rRdrBqhSnz8FUOyH1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743565732; c=relaxed/simple;
	bh=YwTUW/8tC0cRiMYeNCJ7yyb4tykwJb1puupm9zTUoKo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N5dxdMjD2ofZfk8uc0LO68L69G1PEuyVY2nv99DLqzNAL3LrPvtZdHaY14kvnNcNvx70cWgPS8ELvGZvTWFs4rp3NfFIE3X9vNH5dr0M+eDcCssNRbF7QauVV7j7BoxcO9f0qPXGM6mCe48smClGIt69RQXNqR7o3N8Cizhb1dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 48E851A0E5E;
	Wed,  2 Apr 2025 03:48:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id 11F501A;
	Wed,  2 Apr 2025 03:48:46 +0000 (UTC)
Message-ID: <d03ed9d9f7d5e9d8fddca4071e044d26c55a10e2.camel@perches.com>
Subject: Re: [PATCH v2 10/12] checkpatch: Deprecate srcu_read_lock_lite()
 and srcu_read_unlock_lite()
From: Joe Perches <joe@perches.com>
To: paulmck@kernel.org
Cc: rcu@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Date: Tue, 01 Apr 2025 20:48:44 -0700
In-Reply-To: <0cbd404a-856a-4bc3-ab76-eeb839065a2d@paulmck-laptop>
References: <eea8d42f-6d2d-485b-9bb9-4eb77a0e1f95@paulmck-laptop>
	 <20250331210314.590622-10-paulmck@kernel.org>
	 <5588e91ab302e21bf4e30b5208cf3d387f8e7de4.camel@perches.com>
	 <0cbd404a-856a-4bc3-ab76-eeb839065a2d@paulmck-laptop>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: r1jys3rwqi95cymwzuubq1kyp7opq6r4
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 11F501A
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18iieNHgT4im9qCggwliyTVuSvht7h55kA=
X-HE-Tag: 1743565726-689812
X-HE-Meta: U2FsdGVkX1/dxdOWCT4AGdGqdzGp4xLryc6mDh2uzdJ+zNtMPMqCckikTwJF7TZsKzcgfEahzkcEd85xxGWf/FnCLQ8BHiUnyP7APIvXrP+SCm40edhEn0hVphjNFNG92P6IzJULWIqmzvtKNrYOsdfS1zEcyr3W+xyur1qU1C9Yibeqx7YGv6OU8/0JHKr4NutYk5R13p7Cn8zoS2hcBU/By5Yac0/hepNIrY75bCmTaISeoKCSI0zZpaccJmLxkoUw4G3t9SMzJk3wXw2qyHhWDjvNldk+YaNN+hL+HGkdpWKdq8fy0AD+5HcXAbAq

On Tue, 2025-04-01 at 07:05 -0700, Paul E. McKenney wrote:
> On Mon, Mar 31, 2025 at 11:53:25PM -0700, Joe Perches wrote:
> > On Mon, 2025-03-31 at 14:03 -0700, Paul E. McKenney wrote:
> > > Uses of srcu_read_lock_lite() and srcu_read_unlock_lite() are better
> > > served by the new srcu_read_lock_fast() and srcu_read_unlock_fast() A=
PIs.
> > > As in srcu_read_lock_lite() and srcu_read_unlock_lite() would never h=
ave
> > > happened had I thought a bit harder a few months ago.  Therefore, mar=
k
> > > them deprecated.
> >=20
> > Would it be better to convert the 3 existing instances?
>=20
> Both are needed.  The point of these checkpatch.pl changes is to prevent
> other instances from being added.

If those are changed, why not remove the prototypes & functions too?
That would stop more instances being added no?

