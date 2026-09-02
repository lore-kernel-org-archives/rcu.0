Received: from mta1.migadu.com (out-241.mta1.migadu.com [95.215.58.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1054A4409
	for <rcu@vger.kernel.org>; Wed,  2 Sep 2026 14:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788360569; cv=none; b=s3Tp+kErf4dpiZpQyM/JH6NaJSr0BVKpQdDYFpQFy6WXu2mpmHdMWmXXj74D/7p9jMykSCr3QEHQerUK8WV20iexnSKYRkJ0AOWn25CFdeXFdhB1EA/cXNJ0X9ajYPFoBWEvjQqi6JcQLD86/zc7s/CgluL1boZ7o9rYrfxLrJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788360569; c=relaxed/simple;
	bh=PNTYEsienLPJUy1uoqn4OKAXtUVXa5IiTiSzsYklAZw=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=jJ49AfCYRW0PF5YkTIV9UExwLdpCFk5+aUvb/5yeuSeutfTWvb9A5FoMYF486gUyibe55S7jsTcptAC6hQLZp6NRpVN8MnkTJ2wCfKf/okBAX/yOAC4zkabLKwFtb11HgZALz/BFrshXEg9FUuDubyBS05pz1Dfv/P1vFHL84HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jUagR789; arc=none smtp.client-ip=95.215.58.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jUagR789"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=PNTYEsienLPJUy1uoqn4OKAXtUVXa5IiTiSzsYklAZw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788360564; v=1; x=1788965364;
 b=jUagR789yRGahvWwsgQXiUG58bR+xrlRnzuKn6JisQPPYt7DHLQy0RyzGtZCqqCpYnd3h9mD
 q2BMoXjz+/RmxXGilozq7jJT8vDNo1+gjP8dSBDDbekbPE3SnUSLVzXTzP3BCjZIdJRGSClG6Kc
 ugXws4UDIgrOFb1/Abhbg7I4=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3fe4aa4587650eab;
	Wed, 02 Sep 2026 14:49:14 +0000
X-Mizu-Trace-ID: 3fe4aa4587650eab
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 02 Sep 2026 14:49:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <2ff0e6ca8e1e05078a69dbd2b2ccd1e62fc4650f@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] dlm: wait for outstanding SRCU callbacks to complete in
 exit paths
To: "Alexander Aring" <aahringo@redhat.com>
Cc: teigland@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org,
 rcu@vger.kernel.org
In-Reply-To: <CAK-6q+gET5NPczHYexcGXgptGTVnynYuVWzdbDkpsuvnbrymLA@mail.gmail.com>
References: <20260901091836.16906-1-qiang.zhang@linux.dev>
 <CAK-6q+jFXsZpWHrm0CSa8Tr+P3qHDmWVQA+9stXViyUf48CuvA@mail.gmail.com>
 <b530646295a64f5e1cec5bfec5064f1fc79d3d9d@linux.dev>
 <b686c4e5066aa11d7d868097b35e04db58190103@linux.dev>
 <CAK-6q+gET5NPczHYexcGXgptGTVnynYuVWzdbDkpsuvnbrymLA@mail.gmail.com>

>=20
>=20Hi,
>=20
>=20On Wed, Sep 2, 2026 at 10:30 AM Zqiang <qiang.zhang@linux.dev> wrote:
>=20
>=20>=20
>=20> >
> >  > Hi,
> >  >
> >  > On Tue, Sep 1, 2026 at 5:19 AM Zqiang <qiang.zhang@linux.dev> wrot=
e:
> >  >
> >  >
> >  > The dlm_lowcomms_exit() and dlm_midcomms_exit() iterate over the
> >  > srcu protected connection and node hash tables and hand each
> >  > element to call_srcu() for deferred freeing (connection_release()
> >  > and midcomms_node_release()). call_srcu() is asynchronous: the
> >  > callbacks are invoked only after an SRCU grace period, which may
> >  > happen after the exit function has already returned.
> >  >
> >  > These exit functions are reached from exit_dlm() on module unload.
> >  > Once they return, module teardown continues and the module text
> >  > may be unloaded while call_srcu() callbacks are still pending. Whe=
n
> >  > such a callback finally runs, it executes freed module code and
> >  > touches the static SRCU domains that are being torn down, resultin=
g
> >  > in a use-after-free.
> >=20
>=20>  I should rephrase it:
> >=20
>=20>  Due to missed call to the srcu_barrier(), when invoke cleanup_srcu=
_struct()
> >=20
>=20Then there need to be a MUST call of srcu_barrier() before
> cleanup_srcu_struct() every time.

If there are some call_srcu() call, the srcu_barrier() should be called b=
efore cleanup_srcu_struct().
usually, when the cleanup_srcu_struct() run, we should ensure that there =
are no pending SRCU callbacks
or ongoing SRCU grace periods at this time.

there are another reason:

The midcomms_node_release() srcu callback can call call_rcu(), we must wa=
it the all
call_rcu() to complete, because rcu_barrier() which in dlm_memory_exit() =
is required
to successfully intercept these RCU callbacks.

Thanks
Zqiang

>=20
>=20I am confused here.
>=20
>=20- Alex
>
