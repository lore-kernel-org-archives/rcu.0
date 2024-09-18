Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4FD1BAEE0;
	Wed, 18 Sep 2024 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726670442; cv=none; b=eNqg+bYEFEKQG4JsM7v/e6eGTSZwO4gbiAqLhqAe1pf/WOu37r2gwk6hRqGE5yuUDKAG6T5uAwXTrSS22sYDcfYJTj+8Fqs8UNKy/x4SFn2sYYQc2yAOwGkQ+2Ssky3/pox3ZNyfcCc3Cc0d94e7gBtsrO3dWDkstEoggsfjgg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726670442; c=relaxed/simple;
	bh=fx9AZM7i/gALnAF5kjoWhjKiRJORX8mQT4bktzADR4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0mZqdGOO5d9bgtm7H+76mJWYjlyQMpQqUBgR3TaRQ0s/lAxXb2NpeEfGxcIzEqjffQm0t6ImH3HCFMqfNKcjAPD+bNWBUVjJLTeTC0iyfgV5lNxSpiwgALEqNkqR4wTsRsFcMAXRgd1Zm4OfkC9Hl9DY+ulk+wNTaBDMNqCKG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEfveCb0; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEfveCb0"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8a706236bfso381616766b.0;
        Wed, 18 Sep 2024 07:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726670439; x=1727275239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3uHcaosDH+2kqlFhkf7ltR5bOFuDI1RT/7lxsyCyAUQ=;
        b=KEfveCb0gEaIvjM5a9lTFdGWxDbKikkLyBAJzI99faRuJLrSTTsF0R9KX/91gKldEP
         LozIi+8Y5gsKeV9wLrr0e7iQk+aY92gudn8fIvFQDNNzib5M6bKq3fcbQxrk7mbxuc0k
         u+JBJggecwTrOlKRRfEATXmFga2gw9sK9L4gB+m3kU1xFWunBgQp3bKLYy0ptaXS9C7a
         w+MLVBNl14z7St+UxbZ8X3WK6h10RckMWnqjJoMul1mCIr119ORt7sBm7TPnBDi/NaRH
         a3V81Scq0AJuOoVdO3kr7cSi3FIHCVpfOpvxExkE4tEe1d0jXTU9bnb9441B6gEBDnks
         mEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726670439; x=1727275239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3uHcaosDH+2kqlFhkf7ltR5bOFuDI1RT/7lxsyCyAUQ=;
        b=LxsXDwINoGsnlRRa6UOnDryXkqMB95Tu5xHjn966BBfiEe80LJvHprXfD6va8F0PaH
         qHZmalBDqpXz5DWUYQv02qDIvX0IrKwXxVJ3CQi36schkyxoiq5htFrc71yc6Pfha3AR
         95uVCVeDjOAX5Qx6YYIYL7zNNLHKQFeQiESjo+CsrnNyc+jqJCF8ucOj23DtqMjTZK6O
         eC1U1XaUJMZY143Yjb5xH7HYTZUgRG2pIdsbInY2Ipp4u2HnaTVzNsNBtzcXMy3W5YIs
         BmdYfg1Xxat4vgzEa4QhCgwAzTEELOXF7Pu604nyKu6pn26jn5q8yFhxOn/PaCElDCwD
         9iiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlw9kX6HZtw2KDV49NC+2PBlHuEtUIr625oiXhcizgdOltFRFF68VozHdyS3w6w04Cp5R7vecV0KjUu+o=@vger.kernel.org, AJvYcCUnmW4Qbc+iAPAcPiEf7DSSHc984/uGRM9iM3z2Snom9MXCe6UDnpbvgFWia5lYB8bWRya8@vger.kernel.org
X-Gm-Message-State: AOJu0Ywevc+EIEpD74IW3wHsaY43wixLPWUX4LGnGHiJQckPUejvFrb9
	Sm//nDlYSzTg2BSzKy9PoKhrkpVBY1VbYFSaKVvcSx+cg2Q4RDbqJ9el5hkOeOoiikTrd5P/Q/4
	sjxH0lNy+oeFIQ9F2jDf4NQVnDCw=
X-Google-Smtp-Source: AGHT+IFayqEt3iMxQ5M5A7AnOxm3PGP4C+oLCToDpDYoWFq/yqCfgfhmSsqoJzzq4US7UK2z+G6kC7IkTCIp+kwgaow=
X-Received: by 2002:a05:6402:50cb:b0:5c3:c4d1:83d with SMTP id
 4fb4d7f45d1cf-5c41e1b529dmr22239439a12.26.1726670438835; Wed, 18 Sep 2024
 07:40:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8d6c5d10-5750-4472-858c-eadc105453be@suse.cz> <CAHk-=wjmu93njmUVqfkAbGKqHaOKFrTmgU2O=UkP3OOmpCjo4Q@mail.gmail.com>
In-Reply-To: <CAHk-=wjmu93njmUVqfkAbGKqHaOKFrTmgU2O=UkP3OOmpCjo4Q@mail.gmail.com>
From: Uladzislau Rezki <urezki@gmail.com>
Date: Wed, 18 Sep 2024 16:40:25 +0200
Message-ID: <CA+KHdyV=0dpJX_v_tcuTQ-_ree-Yb9ch3F_HqfT4YnH8=zyWng@mail.gmail.com>
Subject: Re: [GIT PULL] slab updates for 6.11
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>, 
	Christoph Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, RCU <rcu@vger.kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, Linus!

On Wed, Sep 18, 2024 at 9:06=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 16 Sept 2024 at 11:45, Vlastimil Babka <vbabka@suse.cz> wrote:
> >
> > There's a small conflict with the rcu tree:
> > https://lore.kernel.org/lkml/20240812124748.3725011b@canb.auug.org.au/
>
> Hmm. The conflict resolution is trivial, but the code itself looks buggy.
>
> Look here, commit 2b55d6a42d14 ("rcu/kvfree: Add kvfree_rcu_barrier()
> API") makes kvfree_rcu_queue_batch() do this:
>
>         bool queued =3D false;
>         ...
>         for (i =3D 0; i < KFREE_N_BATCHES; i++) {
>                 ...
>                         queued =3D queue_rcu_work(system_wq, &krwp->rcu_w=
ork);
>         ...
>         return queued;
>
> and note how that return value is completely nonsensical. It doesn't
> imply anything got queued. It's returning whether the *last* call to
> queue_rcu_work() resulted in queued work.
>
> There is no way the return value is meaningful that I can see, and
> honestly, that means that the code in kvfree_rcu_barrier() looks
> actively buggy, and at worst might be an endless loop
>
> Now, maybe there's some reason why the code works fine, but it looks
> really really wrong. Please fix.
>
> The fix might be either a big comment about why it's ok, or making the
> "queued" assignment be a '|=3D' instead, or perhaps breaking out of the
> loop on the first successful queueing, or whatever.
>
> But not this "randomly return _one_ value of many of the queuing success"=
.
>
Thank you for valuable feedback! Indeed it is hard to follow, even
though it works correctly.
I will add the comment and also break the loop on first queuing as you
suggested!

It does not make sense to loop further because following iterations
are never successful
thus never overwrite "queued" variable(it never reaches the
queue_rcu_work() call).

<snip>
         bool queued =3D false;
         ...
         for (i =3D 0; i < KFREE_N_BATCHES; i++) {
                if (need_offload_krc(krcp)) {
                         queued =3D queue_rcu_work(system_wq, &krwp->rcu_wo=
rk);
         ...
         return queued;
<snip>

if we queued, "if(need_offload_krc())" condition is never true anymore.

Below refactoring makes it clear. I will send the patch to address it.

<snip>
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a60616e69b66..b1f883fcd918 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3607,11 +3607,12 @@ kvfree_rcu_queue_batch(struct kfree_rcu_cpu *krcp)
                        }

                        // One work is per one batch, so there are three
-                       // "free channels", the batch can handle. It can
-                       // be that the work is in the pending state when
-                       // channels have been detached following by each
-                       // other.
+                       // "free channels", the batch can handle. Break
+                       // the loop since it is done with this CPU thus
+                       // queuing an RCU work is _always_ success here.
                        queued =3D queue_rcu_work(system_unbound_wq,
&krwp->rcu_work);
+                       WARN_ON_ONCE(!queued);
+                       break;
                }
        }
<snip>

Thanks!

--=20
Uladzislau Rezki
