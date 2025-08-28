Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BD530C615;
	Thu, 28 Aug 2025 10:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756378054; cv=none; b=J/Xpvp7L9lxVLVii9tfChjIGqZBusoUqCb6eL/MIaUeAK5uCwTrC4uKRl0SwnuC6hmxnCgh0AJ2O/oVHmPOyD76VCAAcfu9vJn8pHZ5oTCfmWZK7n1xpj9AZzETYVb5uLH0HIEYmnKwBXyCjrfmrbgDh1d4T7qihrGQjFfqtIkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756378054; c=relaxed/simple;
	bh=bH1+9tCrgFxXQQMyQJqGifsOSchntb5WWHYa+mdkBbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VZWzSgZGge28ysvVotVAerBr9d70KlcARcN4UDra0MLlxqEhIpb+AcsdijbfLGsBZCffxizWQSUb520p/pSq1LVTx4smqgNN+/s9qISDYArolcq9l6LBw58gP9iWnV0uZxeQwMi8nQN6szii72iRe7E4d45J9l82OL2ROB8fO1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=fvofJaPk; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="fvofJaPk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756378022; x=1756982822; i=spasswolf@web.de;
	bh=0WUJqsrAYnQkrI39CYTgeGfmXA2oXBJe4Y8RSF3Rocg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fvofJaPk04UEbJ0tgOPTIBGpJ+5yn1ns6pnWzY9auAAeMJh9B661CO0seeDvNONm
	 idpKw4Sqb/9FPxqxLNdl2CLeFTB35nkaJbNQaCo5N37lk9ZchG7oc+JgTQw9KFnql
	 ENlrQWDj/HaeTigmLBFJDqP+HND/AI4yNWw6LkFz9GROqOmDxKhaltszvNPwmGf6G
	 54gR9B6KEXw30WNc+7EHAwfq7rnCV5r37Rw7PryUMSblTmB7YpsKL22JwD7lMrWQQ
	 EQ9f7+8zm5GOrDqCh88ELVGiEGZ/TyldFMfeCtu7Z6P2Q5GW1XydgraXW0wAPqA+0
	 bQZMZaiHeA/KCnxaWQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([95.223.134.88]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MXocY-1uzJP73lBk-00Ynov; Thu, 28 Aug 2025 12:47:02 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: vbabka@suse.cz
Cc: Bert Karwatzki <spasswolf@web.de>,
	Liam.Howlett@oracle.com,
	cl@gentwo.org,
	harry.yoo@oracle.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rt-devel@lists.linux.dev,
	maple-tree@lists.infradead.org,
	rcu@vger.kernel.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	surenb@google.com,
	urezki@gmail.com
Subject: commit 4ca04daa23305 fails to compile with PREEMPT_RT=y
Date: Thu, 28 Aug 2025 12:46:57 +0200
Message-ID: <20250828104658.172649-1-spasswolf@web.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: 20250827-slub-percpu-caches-v6-2-f0f775a3f73f@suse.cz
References: 
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x8k7jnSLTIhjtWsrF57/r+ECHgT4S23aBF+WvPLQmxRQ3qbrz5Y
 BMzXjERZIhcrvgm87eBXEIlDnXJGKF3/Ms7eF6CIdyONbD98QI58RdZc2nhWL2SVAtUcZCQ
 e/BBxXpK01UvZAIXxHpebOLizmd0t7w46q0t6y5y/PMHD45G37CAx5c0v09E+o6K3FKZ0lz
 uGUaqyeXAFY313t+aashQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Np0hriZfIZM=;c6DZNBGjuihKHBEYf5ipWmKa4CR
 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
 n40O4zoAjcUYx4VMoRt

In noticed that linux next-20250828 fails to compile with the following er=
ror:

In file included from ./include/linux/spinlock.h:63,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/mm.h:7,
                 from mm/slub.c:13:
mm/slub.c: In function =E2=80=98__pcs_replace_empty_main=E2=80=99:
mm/slub.c:4727:64: error: =E2=80=98local_trylock_t=E2=80=99 {aka =E2=80=98=
__seg_gs struct spinlock=E2=80=99} has no member named =E2=80=98llock=E2=
=80=99; did you mean =E2=80=98lock=E2=80=99?
 4727 |         lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock.llo=
ck));
      |                                                                ^~~=
~~
./include/linux/lockdep.h:392:61: note: in definition of macro =E2=80=98lo=
ckdep_assert_held=E2=80=99
  392 | #define lockdep_assert_held(l)                  do { (void)(l); } =
while (0)
      |                                                             ^
./include/linux/percpu-defs.h:245:9: note: in expansion of macro =E2=80=98=
__verify_pcpu_ptr=E2=80=99
  245 |         __verify_pcpu_ptr(ptr);                                   =
      \
      |         ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:256:27: note: in expansion of macro =E2=80=
=98raw_cpu_ptr=E2=80=99
  256 | #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
      |                           ^~~~~~~~~~~
mm/slub.c:4727:29: note: in expansion of macro =E2=80=98this_cpu_ptr=E2=80=
=99
 4727 |         lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock.llo=
ck));
      |                             ^~~~~~~~~~~~
mm/slub.c:4727:64: error: =E2=80=98local_trylock_t=E2=80=99 {aka =E2=80=98=
__seg_gs struct spinlock=E2=80=99} has no member named =E2=80=98llock=E2=
=80=99; did you mean =E2=80=98lock=E2=80=99?
 4727 |         lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock.llo=
ck));
      |                                                                ^~~=
~~
./include/linux/lockdep.h:392:61: note: in definition of macro =E2=80=98lo=
ckdep_assert_held=E2=80=99
  392 | #define lockdep_assert_held(l)                  do { (void)(l); } =
while (0)
      |                                                             ^
./include/linux/percpu-defs.h:246:9: note: in expansion of macro =E2=80=98=
arch_raw_cpu_ptr=E2=80=99
  246 |         arch_raw_cpu_ptr(ptr);                                    =
      \
      |         ^~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:256:27: note: in expansion of macro =E2=80=
=98raw_cpu_ptr=E2=80=99
  256 | #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
      |                           ^~~~~~~~~~~
mm/slub.c:4727:29: note: in expansion of macro =E2=80=98this_cpu_ptr=E2=80=
=99
 4727 |         lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock.llo=
ck));
      |                             ^~~~~~~~~~~~
mm/slub.c:4727:64: error: =E2=80=98local_trylock_t=E2=80=99 {aka =E2=80=98=
__seg_gs struct spinlock=E2=80=99} has no member named =E2=80=98llock=E2=
=80=99; did you mean =E2=80=98lock=E2=80=99?
 4727 |         lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock.llo=
ck));
      |                                                                ^~~=
~~
./include/linux/lockdep.h:392:61: note: in definition of macro =E2=80=98lo=
ckdep_assert_held=E2=80=99
  392 | #define lockdep_assert_held(l)                  do { (void)(l); } =
while (0)
      |                                                             ^
./arch/x86/include/asm/percpu.h:68:10: note: in expansion of macro =E2=80=
=98TYPEOF_UNQUAL=E2=80=99
   68 |         (TYPEOF_UNQUAL(*(_ptr)) __force __kernel *)tcp_ptr__;     =
      \
      |          ^~~~~~~~~~~~~
./include/linux/percpu-defs.h:246:9: note: in expansion of macro =E2=80=98=
arch_raw_cpu_ptr=E2=80=99
  246 |         arch_raw_cpu_ptr(ptr);                                    =
      \
      |         ^~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:256:27: note: in expansion of macro =E2=80=
=98raw_cpu_ptr=E2=80=99
  256 | #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
      |                           ^~~~~~~~~~~
mm/slub.c:4727:29: note: in expansion of macro =E2=80=98this_cpu_ptr=E2=80=
=99
 4727 |         lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock.llo=
ck));
      |                             ^~~~~~~~~~~~
  CC      net/ipv4/route.o
mm/slub.c: In function =E2=80=98__pcs_install_empty_sheaf=E2=80=99:
  AS      lib/crypto/x86/sha1-ni-asm.o
  CC      drivers/acpi/ec.o
mm/slub.c:5604:64: error: =E2=80=98local_trylock_t=E2=80=99 {aka =E2=80=98=
__seg_gs struct spinlock=E2=80=99} has no member named =E2=80=98llock=E2=
=80=99; did you mean =E2=80=98lock=E2=80=99?
 5604 |         lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock.llo=
ck));
      |                                                                ^~~=
~~
./include/linux/lockdep.h:392:61: note: in definition of macro =E2=80=98lo=
ckdep_assert_held=E2=80=99
  392 | #define lockdep_assert_held(l)                  do { (void)(l); } =
while (0)
      |                                                             ^
./include/linux/percpu-defs.h:245:9: note: in expansion of macro =E2=80=98=
__verify_pcpu_ptr=E2=80=99
  245 |         __verify_pcpu_ptr(ptr);                                   =
      \
      |         ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:256:27: note: in expansion of macro =E2=80=
=98raw_cpu_ptr=E2=80=99
  256 | #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
      |                           ^~~~~~~~~~~
mm/slub.c:5604:29: note: in expansion of macro =E2=80=98this_cpu_ptr=E2=80=
=99
 5604 |         lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock.llo=
ck));
      |                             ^~~~~~~~~~~~
mm/slub.c:5604:64: error: =E2=80=98local_trylock_t=E2=80=99 {aka =E2=80=98=
__seg_gs struct spinlock=E2=80=99} has no member named =E2=80=98llock=E2=
=80=99; did you mean =E2=80=98lock=E2=80=99?
 5604 |         lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock.llo=
ck));
      |                                                                ^~~=
~~
./include/linux/lockdep.h:392:61: note: in definition of macro =E2=80=98lo=
ckdep_assert_held=E2=80=99
  392 | #define lockdep_assert_held(l)                  do { (void)(l); } =
while (0)
      |                                                             ^
./include/linux/percpu-defs.h:246:9: note: in expansion of macro =E2=80=98=
arch_raw_cpu_ptr=E2=80=99
  246 |         arch_raw_cpu_ptr(ptr);                                    =
      \
      |         ^~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:256:27: note: in expansion of macro =E2=80=
=98raw_cpu_ptr=E2=80=99
  256 | #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
      |                           ^~~~~~~~~~~
mm/slub.c:5604:29: note: in expansion of macro =E2=80=98this_cpu_ptr=E2=80=
=99
 5604 |         lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock.llo=
ck));
      |                             ^~~~~~~~~~~~
mm/slub.c:5604:64: error: =E2=80=98local_trylock_t=E2=80=99 {aka =E2=80=98=
__seg_gs struct spinlock=E2=80=99} has no member named =E2=80=98llock=E2=
=80=99; did you mean =E2=80=98lock=E2=80=99?
 5604 |         lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock.llo=
ck));
      |                                                                ^~~=
~~
./include/linux/lockdep.h:392:61: note: in definition of macro =E2=80=98lo=
ckdep_assert_held=E2=80=99
  392 | #define lockdep_assert_held(l)                  do { (void)(l); } =
while (0)
      |                                                             ^
./arch/x86/include/asm/percpu.h:68:10: note: in expansion of macro =E2=80=
=98TYPEOF_UNQUAL=E2=80=99
   68 |         (TYPEOF_UNQUAL(*(_ptr)) __force __kernel *)tcp_ptr__;     =
      \
      |          ^~~~~~~~~~~~~
./include/linux/percpu-defs.h:246:9: note: in expansion of macro =E2=80=98=
arch_raw_cpu_ptr=E2=80=99
  246 |         arch_raw_cpu_ptr(ptr);                                    =
      \
      |         ^~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:256:27: note: in expansion of macro =E2=80=
=98raw_cpu_ptr=E2=80=99
  256 | #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
      |                           ^~~~~~~~~~~
mm/slub.c:5604:29: note: in expansion of macro =E2=80=98this_cpu_ptr=E2=80=
=99
 5604 |         lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock.llo=
ck));
      |                             ^~~~~~~~~~~~
mm/slub.c: In function =E2=80=98__pcs_replace_full_main=E2=80=99:
mm/slub.c:5653:64: error: =E2=80=98local_trylock_t=E2=80=99 {aka =E2=80=98=
__seg_gs struct spinlock=E2=80=99} has no member named =E2=80=98llock=E2=
=80=99; did you mean =E2=80=98lock=E2=80=99?
 5653 |         lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock.llo=
ck));
      |                                                                ^~~=
~~
./include/linux/lockdep.h:392:61: note: in definition of macro =E2=80=98lo=
ckdep_assert_held=E2=80=99
  392 | #define lockdep_assert_held(l)                  do { (void)(l); } =
while (0)
      |                                                             ^
./include/linux/percpu-defs.h:245:9: note: in expansion of macro =E2=80=98=
__verify_pcpu_ptr=E2=80=99
  245 |         __verify_pcpu_ptr(ptr);                                   =
      \
      |         ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:256:27: note: in expansion of macro =E2=80=
=98raw_cpu_ptr=E2=80=99
  256 | #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
      |                           ^~~~~~~~~~~
mm/slub.c:5653:29: note: in expansion of macro =E2=80=98this_cpu_ptr=E2=80=
=99
 5653 |         lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock.llo=
ck));
      |                             ^~~~~~~~~~~~
mm/slub.c:5653:64: error: =E2=80=98local_trylock_t=E2=80=99 {aka =E2=80=98=
__seg_gs struct spinlock=E2=80=99} has no member named =E2=80=98llock=E2=
=80=99; did you mean =E2=80=98lock=E2=80=99?
 5653 |         lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock.llo=
ck));
      |                                                                ^~~=
~~
./include/linux/lockdep.h:392:61: note: in definition of macro =E2=80=98lo=
ckdep_assert_held=E2=80=99
  392 | #define lockdep_assert_held(l)                  do { (void)(l); } =
while (0)
      |                                                             ^
./include/linux/percpu-defs.h:246:9: note: in expansion of macro =E2=80=98=
arch_raw_cpu_ptr=E2=80=99
  246 |         arch_raw_cpu_ptr(ptr);                                    =
      \
      |         ^~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:256:27: note: in expansion of macro =E2=80=
=98raw_cpu_ptr=E2=80=99
  256 | #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
      |                           ^~~~~~~~~~~
mm/slub.c:5653:29: note: in expansion of macro =E2=80=98this_cpu_ptr=E2=80=
=99
 5653 |         lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock.llo=
ck));
      |                             ^~~~~~~~~~~~
mm/slub.c:5653:64: error: =E2=80=98local_trylock_t=E2=80=99 {aka =E2=80=98=
__seg_gs struct spinlock=E2=80=99} has no member named =E2=80=98llock=E2=
=80=99; did you mean =E2=80=98lock=E2=80=99?
 5653 |         lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock.llo=
ck));
      |                                                                ^~~=
~~
./include/linux/lockdep.h:392:61: note: in definition of macro =E2=80=98lo=
ckdep_assert_held=E2=80=99
  392 | #define lockdep_assert_held(l)                  do { (void)(l); } =
while (0)
      |                                                             ^
./arch/x86/include/asm/percpu.h:68:10: note: in expansion of macro =E2=80=
=98TYPEOF_UNQUAL=E2=80=99
   68 |         (TYPEOF_UNQUAL(*(_ptr)) __force __kernel *)tcp_ptr__;     =
      \
      |          ^~~~~~~~~~~~~
./include/linux/percpu-defs.h:246:9: note: in expansion of macro =E2=80=98=
arch_raw_cpu_ptr=E2=80=99
  246 |         arch_raw_cpu_ptr(ptr);                                    =
      \
      |         ^~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:256:27: note: in expansion of macro =E2=80=
=98raw_cpu_ptr=E2=80=99
  256 | #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
      |                           ^~~~~~~~~~~
mm/slub.c:5653:29: note: in expansion of macro =E2=80=98this_cpu_ptr=E2=80=
=99
 5653 |         lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock.llo=
ck));
      |                             ^~~~~~~~~~~~


The reason for this is that local_trylock_t is mapped to spinlock_t on=20
PREEMPT_RT=3Dy and spinlock_t has no member named llock.
If one changes the assertion like this the kernel compiles with PREEMPT_RT=
=3Dy, too,
but I'm not sure if the assertion is correctly used here. If not one has t=
o use
#ifdef PREEMPT_RT here I think:

diff --git a/mm/slub.c b/mm/slub.c
index 3ab91a1409f5..2138fecc8d37 100644
=2D-- a/mm/slub.c
+++ b/mm/slub.c
@@ -4724,7 +4724,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struc=
t slub_percpu_sheaves *pcs,
 	struct slab_sheaf *full;
 	bool can_alloc;
=20
-	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock.llock));
+	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
=20
 	if (pcs->spare && pcs->spare->size > 0) {
 		swap(pcs->main, pcs->spare);
@@ -5601,7 +5601,7 @@ static void __slab_free(struct kmem_cache *s, struct=
 slab *slab,
 static void __pcs_install_empty_sheaf(struct kmem_cache *s,
 		struct slub_percpu_sheaves *pcs, struct slab_sheaf *empty)
 {
-	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock.llock));
+	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
=20
 	/* This is what we expect to find if nobody interrupted us. */
 	if (likely(!pcs->spare)) {
@@ -5650,7 +5650,7 @@ __pcs_replace_full_main(struct kmem_cache *s, struct=
 slub_percpu_sheaves *pcs)
 	bool put_fail;
=20
 restart:
-	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock.llock));
+	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
=20
 	put_fail =3D false;
=20

Bert Karwatzki
