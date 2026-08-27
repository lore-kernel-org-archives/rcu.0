Received: from mta1.migadu.com (out-45.mta1.migadu.com [95.215.58.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F8845A2AD
	for <rcu@vger.kernel.org>; Thu, 27 Aug 2026 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787838015; cv=none; b=Ch8VxmNLTFLle+ys6PtJUx2IXQTV4otXkdJIsFxbYGUNN/Ix1BbocTfb2uP7fEPFB+zxv4Ei+6rDaBW4SfGdKgH54b8tbkd2vQaOClaNcDs8Zudy3tSCtRaqMTINTsvvLffdh2zlCywnoMm1rJ/YfAncwOdeJWCGCjYe7mu2+00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787838015; c=relaxed/simple;
	bh=QbDr5AegvBQUfylRvluvNUQKq4sIMyDkgCg5Cj3a4Ks=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=DydQATZHYgY4jSlTkzyg8fScLtN7Ios3jZxlNi0zzZXmnLPAQ/clKul2Y/P+s3wzKUovNZTYKR5Uxxc1WWFa0uuGKk9wDpaUSUpfOPkG/hiIBcHO+qArhiAyzlLMyG+zQoG6+3anE9Qd5JR0ac9+6hVoNDTdX2RmkJ8E/09Bbkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IgQWXkEA; arc=none smtp.client-ip=95.215.58.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IgQWXkEA"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=QbDr5AegvBQUfylRvluvNUQKq4sIMyDkgCg5Cj3a4Ks=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787838008; v=1; x=1788442808;
 b=IgQWXkEArlPCNUsbte/zrCTOHXkMAvFS2YBt7w/iGARKp9Q/COQRpUNhP6ekCuFUz1GqtOtM
 gOOOAEIFT5mukfw+A55pKihvOmwYCKZMx76u4umgUtNJqNA2ILU7TXLH/UMCM0i5A/0Q5Fl2V7U
 YTNt6wRZ8Sn9pIuuxLqAJwAs=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 54c0bf2086df733c;
	Thu, 27 Aug 2026 13:40:08 +0000
X-Mizu-Trace-ID: 54c0bf2086df733c
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 13:40:08 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <d981cbddec4ebac0ba00fa0fce85d04982a45c42@linux.dev>
TLS-Required: No
Subject: Re: [BUG] srcu: false-positive WARN in cleanup_srcu_struct() after
 78a38cbf6f20
To: "Sunho Park" <shpark061104@gmail.com>, paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org,
 syzbot+d4faf7db59e11f6fd1ab@syzkaller.appspotmail.com,
 rcu@vger.kernel.org
In-Reply-To: <28ac9afd-92dc-4c92-91f3-94f025977ca7@gmail.com>
References: <20260824105625.3725157-1-shpark061104@gmail.com>
 <494f3e0cdb3692bf13690f4cddd3b40098b51627@linux.dev>
 <24c0edd6-3cdc-4536-ac78-394bf785aad4@gmail.com>
 <0e74e6799bf042293fd1e34e2f242c56786c3de4@linux.dev>
 <9e216978-d884-4d56-b39f-d134f78a4999@gmail.com>
 <eb2132ad05cd3804a8f2a170de441d79afa793e9@linux.dev>
 <f85c60a0-81d7-41a4-9926-f69cf10222d0@gmail.com>
 <e6350377085ddd85d6ef00d8e9a67bd50c762d3c@linux.dev>
 <698a4d8b6c559f9049ee6fa6b0bc99d45a3d7e44@linux.dev>
 <d036078f31cd8f0fdf0b9185ce8cadef803cc375@linux.dev>
 <28ac9afd-92dc-4c92-91f3-94f025977ca7@gmail.com>

>=20
>=20On 8/27/26 21:40, Zqiang wrote:
>=20
>=20>=20
>=20> Now, I am trying to rephrase your problem in the following way:
> >  1- the step1 call_srcu() trigger SRCU grace period has been end and =
queue sdp->work.
> >  2- the step4 queue srcu callback has been intercepted by step5 srcu_=
barrier()
> >  and start a new SRCU grace period.
> >  3- this new SRCU grace period end, and invoke rcu_seq_end(&sup->srcu=
_gp_seq), queue a timer.
> >  4- the sdp->work begin run, and call srcu_segcblist_advance() with c=
urrent sup->srcu_gp_seq.
> >  so the step4's srcu callback and step5's barrier calback both to be =
run.
> >  all callback finished, but the len not yet update.
> >  5- the srcu_barrier() return, begin call srcu_clean_up(), and then t=
he srcu_clean_up
> >  find the a timer is still pending and the cb_len also not be zero, t=
rigger WARN_ON()
> >  right?
> >=20
>=20Exactly. The real callbacks are properly invoked as srcu_barrier() gu=
arantees. The WARN is triggered only by the two transient states: a pendi=
ng delay_work timer and a stale cblist len. So I think this is a false po=
sitive warning.
>=20
>=20Sorry if my explanations were too wordy.

Would you like to send a patch to fix it ?

remove WARN_ON() or use rcu_segcblist_empty(&sdp->srcu_cblist) to replace=
 rcu_segcblist_n_cbs(&sdp->srcu_cblist) ?

Let's hear Paul's opinion.

Thanks
Zqiang

>=20
>=20Thanks
> Sunho Park
>
