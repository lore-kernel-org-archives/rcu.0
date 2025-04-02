Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92F618B03;
	Wed,  2 Apr 2025 04:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743569375; cv=none; b=acmKv/4L7ya+2NzLfnSoRkKE1XFVGoCM+Fb2EcX2Sry1YTZnAG70NhDuxBjJwbVtJFd69/qMaXP4OlQJ0/yGCaZpAei+iHWJ6SP3EEFB/9Eh+rPFxvx/sbHGFsv7AkqicQ8Ce1RSFO49okLaWw+c5yQnk6CQNhNmJqfmlCGwC2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743569375; c=relaxed/simple;
	bh=qUah2WRjGc35/8pXmSNadWOP5FbZ9k3LwTQt0zZq/DY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N590NL81pntf1Sd9GyT/EUsoC7Ev5S3QD2ZKUanuiX2cGuE1KYWo6+FbucCLTATTOiD1CJj6Xej2gVc9INkS8Y4XPUxKFaM/OkmfVlgQ6TyuZVmiI9oPAjDq3Kqf8WggNICXaG59cnwC+iqvy9ua2QVw3KPElpXuk+Tiy66zV8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 892CB140FFD;
	Wed,  2 Apr 2025 04:49:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf12.hostedemail.com (Postfix) with ESMTPA id 0B1C517;
	Wed,  2 Apr 2025 04:49:12 +0000 (UTC)
Message-ID: <18c590c303e23b90efaa698b2e21017153c1945f.camel@perches.com>
Subject: Re: [PATCH v2 10/12] checkpatch: Deprecate srcu_read_lock_lite()
 and srcu_read_unlock_lite()
From: Joe Perches <joe@perches.com>
To: paulmck@kernel.org
Cc: rcu@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Date: Tue, 01 Apr 2025 21:49:11 -0700
In-Reply-To: <62ef3d73-1a33-4357-925e-9c2fdf1ac8fb@paulmck-laptop>
References: <eea8d42f-6d2d-485b-9bb9-4eb77a0e1f95@paulmck-laptop>
	 <20250331210314.590622-10-paulmck@kernel.org>
	 <5588e91ab302e21bf4e30b5208cf3d387f8e7de4.camel@perches.com>
	 <0cbd404a-856a-4bc3-ab76-eeb839065a2d@paulmck-laptop>
	 <d03ed9d9f7d5e9d8fddca4071e044d26c55a10e2.camel@perches.com>
	 <62ef3d73-1a33-4357-925e-9c2fdf1ac8fb@paulmck-laptop>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 0B1C517
X-Stat-Signature: t4gohoh6ez7eaisa1c4pu3538i7f88z5
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/r8TToW+Pp64WA6Mg2OxQzbVdILkAEtcc=
X-HE-Tag: 1743569352-679309
X-HE-Meta: U2FsdGVkX1++iRjD2fcvMBwdI6osmjlPbkPG3lB828We1v0X5+VMxBeUL526bbKWBsm7H4AQbSoeYZMuxATnv4hjKSn5vnGO1Q2fQWZ08i3Up8/1x9SilEsgvHgYgu3OQNorUS6jRNevGemPweH0bMho8lqKzht2xpln6M6QRVONJdtPfWZm7wTvM6n687AacC/gXecRaPS2FhuoO4oeVSk7v9zUsPXGzqxXsU0YBy+zlsxpDFMxHcQT7hIGpBt8AbbsX+Vq2jWZ/YjUjKcZ78LDnF3Myg6epYO7vhqdlkbwjKgdH815F3DNzOzCmA7F

On Tue, 2025-04-01 at 21:23 -0700, Paul E. McKenney wrote:
> On Tue, Apr 01, 2025 at 08:48:44PM -0700, Joe Perches wrote:
> > On Tue, 2025-04-01 at 07:05 -0700, Paul E. McKenney wrote:
> > > On Mon, Mar 31, 2025 at 11:53:25PM -0700, Joe Perches wrote:
> > > > On Mon, 2025-03-31 at 14:03 -0700, Paul E. McKenney wrote:
> > > > > Uses of srcu_read_lock_lite() and srcu_read_unlock_lite() are bet=
ter
> > > > > served by the new srcu_read_lock_fast() and srcu_read_unlock_fast=
() APIs.
> > > > > As in srcu_read_lock_lite() and srcu_read_unlock_lite() would nev=
er have
> > > > > happened had I thought a bit harder a few months ago.  Therefore,=
 mark
> > > > > them deprecated.
> > > >=20
> > > > Would it be better to convert the 3 existing instances?
> > >=20
> > > Both are needed.  The point of these checkpatch.pl changes is to prev=
ent
> > > other instances from being added.
> >=20
> > If those are changed, why not remove the prototypes & functions too?
> > That would stop more instances being added no?
>=20
> Deprecating it for a cycle then removing the prototypes and functions
> seems a bit more friendly to me.

OK, please remember to push a checkpatch revert or equivalent
when it's done.  Thanks.
